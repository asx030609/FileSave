delete FROM BI_Employee WHERE EmployeeCode LIKE 'J1%' OR EmployeeCode LIKE 'B1%' OR EmployeeCode LIKE 'F2%' OR EmployeeCode LIKE 'Z3%';

USE [FusionFLK]

IF EXISTS(SELECT * FROM DBO.SYSOBJECTS WHERE ID=OBJECT_ID(N'PRO_001') and OBJECTPROPERTY(ID, N'IsProcedure')=1)
	DROP PROC PRO_001;
GO

CREATE PROC PRO_001
AS
	DECLARE @error INT =0 --�����в����Ĵ����¼
	--��������
	BEGIN TRANSACTION
		--PRINT('�洢���̽���������')
		--ʵ���û������
		Declare @i int;	--�������
		Declare @k int;	--�������ͣ�1��װ���װ࣬2��ӻ��װ࣬3��װ��װ࣬4������װ࣬5��װ���Ұ࣬6��ӻ��Ұ࣬7��װ���Ұ࣬8������Ұ�
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
					when 1 then (cast(@i as varchar) + '#�װ��ӻ�')
					when 2 then (cast(@i as varchar) + '#�װ��װ��')
					when 3 then (cast(@i as varchar) + '#�װ��װ��')
					when 4 then (cast(@i as varchar) + '#�װ������')
					when 5 then (cast(@i as varchar) + '#�Ұ��ӻ�')
					when 6 then (cast(@i as varchar) + '#�Ұ��װ��')
					when 7 then (cast(@i as varchar) + '#�Ұ��װ��')
					when 8 then (cast(@i as varchar) + '#�Ұ������')
					end;
				
				print(@EmpCode + '--' + @EmpName);
				INSERT [dbo].[BI_Employee]([EmployeeCode], [EmployeeName], [Sex], [OrganizationCode], [EmploymentCode], [Address], [Phone], [Email], [JobStatus], [Remark], [CreateTime], [UpdateTime], [RowVersion])
					VALUES (@EmpCode, @EmpName, 2, '', '', '', '', '', 0, '', CONVERT(datetime, '2021/5/9 9:09:25', 101), CONVERT(datetime, '2021/5/9 9:09:25', 101), NEWID());
				set @i = @i + 1;
			end;
			set @k = @k + 1;
		end;
		
		SET @error +=@@ERROR
		----�ж�������ύ���߻ع�
		IF(@error <> 0)
			BEGIN
				ROLLBACK TRANSACTION
				RETURN -1 --���ò�����������ʶ
			END
		ELSE
			BEGIN
				COMMIT TRANSACTION
				RETURN 1 --�����ɹ��ı�ʶ
			END
GO

DECLARE @V_RESULT NVARCHAR(50)
EXECUTE @V_RESULT=PRO_001;
PRINT(@V_RESULT);
GO

----�����Ӻý�ɫ֮���������û������ɫ
--INSERT [dbo].[SYS_UserRole]([Id], [UserId], [RoleId])
--	SELECT NEWID(),ID,'65e9acb3-c7e2-43f0-a06f-937b6af6950f' FROM SYS_User where UserName LIKE 'J1%' OR UserName LIKE 'B1%' OR UserName LIKE 'F2%' OR UserName LIKE 'Z3%';