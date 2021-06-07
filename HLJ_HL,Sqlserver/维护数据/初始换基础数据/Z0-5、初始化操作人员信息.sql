delete FROM BI_Employee WHERE EmployeeCode LIKE 'J1%' OR EmployeeCode LIKE 'B1%' OR EmployeeCode LIKE 'F2%' OR EmployeeCode LIKE 'Z3%';

USE [FusionFLK]

IF EXISTS(SELECT * FROM DBO.SYSOBJECTS WHERE ID=OBJECT_ID(N'PRO_001') and OBJECTPROPERTY(ID, N'IsProcedure')=1)
	DROP PROC PRO_001;
GO

CREATE PROC PRO_001
AS
	DECLARE @error INT =0 --事物中操作的错误记录
	--开启事物
	BEGIN TRANSACTION
		--PRINT('存储过程结束。。。')
		--实现用户的添加
		Declare @i int;	--机组序号
		Declare @k int;	--机组类型，1包装机甲班，2卷接机甲班，3封装箱甲班，4嘴棒机甲班，5包装机乙班，6卷接机乙班，7封装箱乙班，8嘴棒机乙班
		Declare @EmpCode varchar(50);
		Declare @EmpName varchar(50);
		
		set @k = 1;
		while(@k <= 8)
		begin
			set @i = 1;
			while(@i <= 13)	
			begin	
				if((@k=3 or  @k=7)AND @i > 3) break;
				if((@k=4 or  @k=8)AND @i > 5) break;
				set @EmpCode = 
					case @k
					when 1 then 'J1'+RIGHT('00' + CAST(@i as varchar), 2)+'01'
					when 2 then 'B1'+RIGHT('00' + CAST(@i as varchar), 2)+'01'
					when 3 then 'F2'+RIGHT('00' + CAST(@i as varchar), 2)+'01'
					when 4 then 'Z3'+RIGHT('00' + CAST(@i as varchar), 2)+'01'
					when 5 then 'J1'+RIGHT('00' + CAST(@i as varchar), 2)+'02'
					when 6 then 'B1'+RIGHT('00' + CAST(@i as varchar), 2)+'02'
					when 7 then 'F2'+RIGHT('00' + CAST(@i as varchar), 2)+'02'
					when 8 then 'Z3'+RIGHT('00' + CAST(@i as varchar), 2)+'02'
					end;
				set @EmpName = 
					case @k
					when 1 then (cast(@i as varchar) + '#甲班卷接机')
					when 2 then (cast(@i as varchar) + '#甲班包装机')
					when 3 then (cast(@i as varchar) + '#甲班封装机')
					when 4 then (cast(@i as varchar) + '#甲班嘴棒机')
					when 5 then (cast(@i as varchar) + '#乙班卷接机')
					when 6 then (cast(@i as varchar) + '#乙班包装机')
					when 7 then (cast(@i as varchar) + '#乙班封装机')
					when 8 then (cast(@i as varchar) + '#乙班嘴棒机')
					end;
				
				print(@EmpCode + '--' + @EmpName);
				INSERT [dbo].[BI_Employee]([EmployeeCode], [EmployeeName], [Sex], [OrganizationCode], [EmploymentCode], [Address], [Phone], [Email], [JobStatus], [Remark], [CreateTime], [UpdateTime], [RowVersion])
					VALUES (@EmpCode, @EmpName, 2, '', '', '', '', '', 0, '', CONVERT(datetime, '2021/5/9 9:09:25', 101), CONVERT(datetime, '2021/5/9 9:09:25', 101), NEWID());
				set @i = @i + 1;
			end;
			set @k = @k + 1;
		end;
		
		SET @error +=@@ERROR
		----判断事务的提交或者回滚
		IF(@error <> 0)
			BEGIN
				ROLLBACK TRANSACTION
				RETURN -1 --设置操作结果错误标识
			END
		ELSE
			BEGIN
				COMMIT TRANSACTION
				RETURN 1 --操作成功的标识
			END
GO

DECLARE @V_RESULT NVARCHAR(50)
EXECUTE @V_RESULT=PRO_001;
PRINT(@V_RESULT);
GO

----最后，添加好角色之后，批量给用户赋予角色
--INSERT [dbo].[SYS_UserRole]([Id], [UserId], [RoleId])
--	SELECT NEWID(),ID,'65e9acb3-c7e2-43f0-a06f-937b6af6950f' FROM SYS_User where UserName LIKE 'J1%' OR UserName LIKE 'B1%' OR UserName LIKE 'F2%' OR UserName LIKE 'Z3%';