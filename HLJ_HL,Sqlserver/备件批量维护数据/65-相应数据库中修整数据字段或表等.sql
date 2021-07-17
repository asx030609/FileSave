use [TestDB]

--/*
Alter table TB01 ADD ShelfNo nvarchar(50);
GO
Alter table TB01 ADD LocationNo nvarchar(50);
GO
Alter table TB01 ADD LayerNo nvarchar(50);
GO
Alter table TB01 ADD LocationCode nvarchar(50);
GO
Alter table TB01 ADD ID INT IDENTITY(1,1);
GO
Alter table TB01 add UnitCode nvarchar(50);
GO
Alter table TB01 add [Transfer] nvarchar(50);
GO
UPDATE TB01 SET [Transfer]=1000;
Alter table TB01 add ProductUnitId nvarchar(50);
GO
Alter table TB01 add ModelCode nvarchar(32);
GO

----更新新添加字段数据
UPDATE TB01 SET ShelfNo=SUBSTRING(LocationName,1,2),LayerNo=SUBSTRING(LocationName, 4,2),LocationNo=SUBSTRING(LocationName,7,2);
UPDATE TB01 SET LocationCode=SUBSTRING(LocationName,1,2)+'-'+SUBSTRING(LocationName, 4,2)+'-'+SUBSTRING(LocationName,7,2);
GO
--*/
if exists(select * from dbo.sysobjects where id=object_id(N'pro_001') and OBJECTPROPERTY(id, N'IsProcedure')=1)	--或者使用select * from dbo.sysobjects where xtype='P';？
	drop procedure pro_001;
go
----正常情况下是一柜一层最多32位，但是用友上尽然可以到58
----1-N柜，1-M层，N、M已经固定，要在这固定的基础上添加33-58位
----找出N、M
create PROC pro_001
AS
BEGIN
	DECLARE @unitTotalNum int;
	set @unitTotalNum = (select count(1) from TB01);
	Declare @unitName nvarchar(50);
	Declare @unitCode nvarchar(50);
	Declare @transfer nvarchar(50);
	Declare @v_ProductCode nvarchar(100);
	declare @unitId nvarchar(50);
	declare @v_Model nvarchar(32);
	declare @IDNum int;
	if OBJECT_ID('tempdb..#TP_01') is not null drop table #TP_01;
	SELECT *
	into #TP_01
	FROM
	(SELECT ProductUnitId,UnitName,ProductCode FROM TB01 where 1=0) AS A;

	set @IDNum=1;
	while(@IDNum <= @unitTotalNum)
	begin
		----print(@IDNum);
		select @unitName=UnitName,@v_Model=ModelCode,@v_ProductCode=ProductCode from TB01 WHERE ID=@IDNum;	--ID是自增唯一键，identify(1,1)
		select @unitCode=UnitCode from FusionBJK.DBO.BI_ProductUnit WHERE UnitName=@unitName;	--导入的数据没有编码，所以还是从原先数据加
		update TB01 set UnitCode=@unitCode where ID=@IDNum;
		--select @transfer=TransferRate,@unitId=Id from FusionBJK.DBO.BI_ProductUnit WHERE UnitName=@unitName and UnitType=1;
		----还是得通过临时表操作ProductUnitId**************---------------------
		set @unitId = null;
		select @unitId=ProductUnitId from #TP_01 WHERE UnitName=@unitName and ProductCode=@v_ProductCode;
		--通过这两步调试进去看@unitId，发现使用select @unitId=ProductUnitId from TB01 WHERE UnitName=@unitName and ProductCode=@v_ProductCode;
		--就算后面使用Update更新了,得到的结果也为null或空，这是因为select @unitId是取后面那条数据导致的吗？很有可能
		--要通过临时表方式,
		--IF(@v_ProductCode='00604569790')	
		--	PRINT(@v_ProductCode);
		--print(@unitId + '-' + @v_ProductCode);
		if(''=ISNULL(@unitId,''))
			set @unitId=NEWID();
		ELSE
			PRINT('存在产品'+ @v_ProductCode);
		--print(@unitId + ',' + @v_ProductCode);
		update TB01 set ProductUnitId=@unitId where ID=@IDNum;
		Insert into #TP_01 SELECT @unitId,@unitName,@v_ProductCode;
		----结束临时表操作ProductUnitId**************---------------------------------

		SET @IDNum=@IDNum+1;
	end;
END;
GO
UPDATE TB01 SET ModelCode=SubString(ModelName, 1, 32);
EXECUTE pro_001;
GO
--SELECT SUBSTRING(LocationName,1,2) '架数',SUBSTRING(LocationName, 4,2) '层数',SUBSTRING(LocationName,7,2) '位数',LocationName FROM TB01;
--SELECT * FROM TB01;