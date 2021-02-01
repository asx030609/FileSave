USE [FusionPFK]

IF EXISTS(SELECT * FROM DBO.SYSOBJECTS WHERE ID=OBJECT_ID(N'PRO_001') and OBJECTPROPERTY(ID, N'IsProcedure')=1)
	DROP PROC PRO_001;
GO

CREATE PROC PRO_001
AS
	DECLARE @error INT =0 --�����в����Ĵ����¼
	DECLARE @ROLE_ID NVARCHAR(50)
	DECLARE @USER_ID NVARCHAR(50)
	--��������
	BEGIN TRANSACTION
		--PRINT('�洢���̽���������')
		--ʵ���û������
		SET @USER_ID=NEWID()
		INSERT INTO [dbo].[SYS_User]([Id],[UserName],[Password],[Name],[Active],[Description],[CreateTime],[UpdateTime],[RowVersion],[FailCount],[IsLock],[LockTime])VALUES
			(@USER_ID, '[UserName]001','123456','Name01','true','Description001',GETDATE(),GETDATE(),NEWID(),70,0,NULL)
		SET @error +=@@ERROR
		--ʵ�ֽ�ɫ�����
		SET @ROLE_ID=NEWID()
		INSERT INTO [dbo].[SYS_Role]([Id],[Name],[RoleName],[Active],[Description],[CreateTime],[UpdateTime],[RowVersion]) VALUES(@ROLE_ID,'test20210131001','roleName001'
			,'TRUE', '[Description]001', GETDATE(), GETDATE(),NEWID())
		SET @error +=@@ERROR
		--ʵ���û���ɫ�����
		INSERT [dbo].[SYS_UserRole]([Id], [UserId], [RoleId])
			VALUES (NEWID(), @USER_ID, @ROLE_ID)
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