
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
		Declare @i int;	--序号
		Declare @EmpCode varchar(50);
		Declare @EmpName varchar(50);
		
		set @i = 1;
		while(@i <= 5)	
		begin	
			set @EmpCode = 'test'+RIGHT('00' + CAST(@i as varchar), 2);
			set @EmpName = '测试人员'+RIGHT('00' + CAST(@i as varchar), 2);
			print(@EmpCode + '--' + @EmpName);
			INSERT [dbo].[BI_Employee]([EmployeeCode], [EmployeeName], [Sex], [OrganizationCode], [EmploymentCode], [Address], [Phone], [Email], [JobStatus], [Remark], [CreateTime], [UpdateTime], [RowVersion])
				VALUES (@EmpCode, @EmpName, 2, '', '', '', '', '', 0, '', CONVERT(datetime, '2021/5/9 9:09:25', 101), CONVERT(datetime, '2021/5/9 9:09:25', 101), NEWID());
			INSERT [dbo].[SYS_User]([Id], [UserName], [Password], [Name], [Active], [Description], [FailCount], [IsLock], [LockTime], [CreateTime], [UpdateTime], [RowVersion])
				VALUES (NEWID(), @EmpCode, '123456', @EmpName, 'True', NULL, 0, 'False', NULL, CONVERT(datetime, '2021/5/9 16:09:31', 101), CONVERT(datetime, '2021/5/9 16:09:31', 101), NEWID());
			set @i = @i + 1;
		end;
		----最后，将员工导入到用户表后，批量给用户赋予角色
		INSERT [dbo].[SYS_UserRole]([Id], [UserId], [RoleId])
			SELECT NEWID(),ID,'B77762F1-63E1-43D9-A2F0-A787A93CCF3B' FROM SYS_User where UserName LIKE 'test%';
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

