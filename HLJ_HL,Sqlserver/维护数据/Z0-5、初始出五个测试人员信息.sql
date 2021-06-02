
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
		Declare @i int;	--���
		Declare @EmpCode varchar(50);
		Declare @EmpName varchar(50);
		
		set @i = 1;
		while(@i <= 5)	
		begin	
			set @EmpCode = 'test'+RIGHT('00' + CAST(@i as varchar), 2);
			set @EmpName = '������Ա'+RIGHT('00' + CAST(@i as varchar), 2);
			print(@EmpCode + '--' + @EmpName);
			INSERT [dbo].[BI_Employee]([EmployeeCode], [EmployeeName], [Sex], [OrganizationCode], [EmploymentCode], [Address], [Phone], [Email], [JobStatus], [Remark], [CreateTime], [UpdateTime], [RowVersion])
				VALUES (@EmpCode, @EmpName, 2, '', '', '', '', '', 0, '', CONVERT(datetime, '2021/5/9 9:09:25', 101), CONVERT(datetime, '2021/5/9 9:09:25', 101), NEWID());
			INSERT [dbo].[SYS_User]([Id], [UserName], [Password], [Name], [Active], [Description], [FailCount], [IsLock], [LockTime], [CreateTime], [UpdateTime], [RowVersion])
				VALUES (NEWID(), @EmpCode, '123456', @EmpName, 'True', NULL, 0, 'False', NULL, CONVERT(datetime, '2021/5/9 16:09:31', 101), CONVERT(datetime, '2021/5/9 16:09:31', 101), NEWID());
			set @i = @i + 1;
		end;
		----��󣬽�Ա�����뵽�û�����������û������ɫ
		INSERT [dbo].[SYS_UserRole]([Id], [UserId], [RoleId])
			SELECT NEWID(),ID,'B77762F1-63E1-43D9-A2F0-A787A93CCF3B' FROM SYS_User where UserName LIKE 'test%';
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

