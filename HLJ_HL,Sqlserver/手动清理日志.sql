SQL2008:
--��SQL2008�������־�ͱ����ڼ�ģʽ�½��У��������������ٵ��ص���ȫģʽ��
USE [master]
GO
ALTER DATABASE [FusionBJK] SET RECOVERY SIMPLE WITH NO_WAIT
GO
ALTER DATABASE [FusionBJK] SET RECOVERY SIMPLE --��ģʽ
GO

USE [FusionBJK]
GO
DBCC SHRINKFILE (N'Fusion_XYPFK_log' , 2, TRUNCATEONLY)
GO

USE [master]
GO
ALTER DATABASE [FusionBJK] SET RECOVERY FULL WITH NO_WAIT
GO
ALTER DATABASE [FusionBJK] SET RECOVERY FULL --��ԭΪ��ȫģʽ
GO

--�����DNName_Log �����֪����sys.database_files����ʲô���ֵĻ�������������ע�͵������в�ѯ
USE [FusionBJK] 
GO
SELECT file_id, name FROM sys.database_files;
GO