SQL2008:
--在SQL2008中清除日志就必须在简单模式下进行，等清除动作完毕再调回到完全模式。
USE [master]
GO
ALTER DATABASE [FusionBJK] SET RECOVERY SIMPLE WITH NO_WAIT
GO
ALTER DATABASE [FusionBJK] SET RECOVERY SIMPLE --简单模式
GO

USE [FusionBJK]
GO
DBCC SHRINKFILE (N'Fusion_XYPFK_log' , 2, TRUNCATEONLY)
GO

USE [master]
GO
ALTER DATABASE [FusionBJK] SET RECOVERY FULL WITH NO_WAIT
GO
ALTER DATABASE [FusionBJK] SET RECOVERY FULL --还原为完全模式
GO

--这里的DNName_Log 如果不知道在sys.database_files里是什么名字的话，可以用以下注释的语句进行查询
USE [FusionBJK] 
GO
SELECT file_id, name FROM sys.database_files;
GO