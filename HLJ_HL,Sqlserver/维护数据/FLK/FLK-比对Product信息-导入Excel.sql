USE [TestDB]
--/*读取Excel数据到数据表TB01
----读取数据到临时表#type
if OBJECT_ID('tempdb..#type') is not null drop table #type;
select  * into #type  from  ----将获取的数据插入临时表
	OPENROWSET ('Microsoft.ACE.OLEDB.12.0'
	, 'Excel 12.0;HDR=Yes;IMEX=1;DATABASE=E:\repository\FileSaveV1\HLJ_HL,Sqlserver\维护数据\FLK\辅料编码(1).csv', TB_BD_AUXILIARYMATERIAL$);

--SELECT * FROM #type;
----//清除相关可能关联的外键表数据
drop table SYN_PRODUCT;

SELECT * INTO SYN_PRODUCT
	FROM #type;
----//插入数据


drop table #type;
go

Alter Table SYN_PRODUCT add ID int IDENTITY(1,1);
GO
Alter Table SYN_PRODUCT add PRODUCT_ORIGIN int;
GO
Alter Table SYN_PRODUCT add PRODUCT_CODE01 NVARCHAR(100);
GO
update SYN_PRODUCT set PRODUCT_ORIGIN=1;
INSERT INTO SYN_PRODUCT(AUXMATERIAL_CODE, PRODUCT_ORIGIN)
	SELECT C.ProductCode,2 FROM FusionFLK.DBO.BI_MatchPalletDetail C WHERE (C.ProductCode NOT IN (SELECT AUXMATERIAL_CODE FROM SYN_PRODUCT));
--update  c set c.PRODUCT_CODE01 = s.ProductCode from SYN_PRODUCT c,FusionFLK.dbo.BI_Product  s where c.PRODUCT_CODE01 = s.ProductCode;
go
Alter PROC pro_001
AS
BEGIN
	DECLARE @unitTotalNum int;
	set @unitTotalNum = (select count(1) from SYN_PRODUCT);
	Declare @v_ProductCode nvarchar(100);
	declare @IDNum int;

	--set @IDNum=1;
	--while(@IDNum <= @unitTotalNum)
	--begin
	--	SET @IDNum=@IDNum+1;
	--end;
END;
GO
EXECUTE pro_001;
GO
