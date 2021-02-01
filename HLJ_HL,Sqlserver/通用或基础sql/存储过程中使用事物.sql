USE [FusionPFK]

IF EXISTS(SELECT * FROM DBO.SYSOBJECTS WHERE ID=OBJECT_ID(N'PRO_001') and OBJECTPROPERTY(ID, N'IsProcedure')=1)
	DROP PROC PRO_001;
GO

CREATE PROC PRO_001
AS
	DECLARE @error INT =0 --事物中操作的错误记录
	DECLARE @ROLE_ID NVARCHAR(50)
	DECLARE @USER_ID NVARCHAR(50)
	--开启事物
	BEGIN TRANSACTION
		--PRINT('存储过程结束。。。')
		--实现用户的添加
		SET @USER_ID=NEWID()
		INSERT INTO [dbo].[SYS_User]([Id],[UserName],[Password],[Name],[Active],[Description],[CreateTime],[UpdateTime],[RowVersion],[FailCount],[IsLock],[LockTime])VALUES
			(@USER_ID, '[UserName]001','123456','Name01','true','Description001',GETDATE(),GETDATE(),NEWID(),70,0,NULL)
		SET @error +=@@ERROR
		--实现角色的添加
		SET @ROLE_ID=NEWID()
		INSERT INTO [dbo].[SYS_Role]([Id],[Name],[RoleName],[Active],[Description],[CreateTime],[UpdateTime],[RowVersion]) VALUES(@ROLE_ID,'test20210131001','roleName001'
			,'TRUE', '[Description]001', GETDATE(), GETDATE(),NEWID())
		SET @error +=@@ERROR
		--实现用户角色的添加
		INSERT [dbo].[SYS_UserRole]([Id], [UserId], [RoleId])
			VALUES (NEWID(), @USER_ID, @ROLE_ID)
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