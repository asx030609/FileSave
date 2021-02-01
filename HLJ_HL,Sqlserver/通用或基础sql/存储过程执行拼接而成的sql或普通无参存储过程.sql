USE [FusionPFK];
GO
if exists(select * from dbo.sysobjects where id=object_id(N'pro_001') and OBJECTPROPERTY(id, N'IsProcedure')=1)	--或者使用select * from dbo.sysobjects where xtype='P';？
	drop procedure pro_001;
go

create PROC pro_001
        @startRowIndexId INT,
        @maxNumberRows  INT
		AS
		BEGIN
			DECLARE @sqlfilter  VARCHAR(max);
			SET @sqlfilter = ' ';
			DECLARE @sqlmain  VARCHAR(max);
			SET @sqlmain = ' ';
			SET @sqlmain = ' SELECT * FROM SYS_Area
				AS tableu';
			EXEC (@sqlmain + @sqlfilter)
		END;
GO

--EXECUTE pro_001  1,1;	----成功
--GO

--DECLARE @RC int
--DECLARE @startRowIndexId int
--DECLARE @maxNumberRows int
--EXECUTE @RC =pro_001  @startRowIndexId,@maxNumberRows	----成功
--PRINT @RC
--GO

if exists(select * from dbo.sysobjects where id=object_id(N'pro_002') and OBJECTPROPERTY(id, N'IsProcedure')=1)
	drop procedure pro_002;
go

create PROC pro_002
		AS
		BEGIN
			SELECT * FROM SYS_Function
		END;
GO

EXECUTE pro_002  ;
GO