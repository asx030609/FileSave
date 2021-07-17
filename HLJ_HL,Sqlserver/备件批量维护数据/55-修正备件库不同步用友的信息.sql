use [FusionBJK]
--/*--将货位编码修整成和用友类似的，因为要重新同步数据，所以删除库存信息和一些其他相关信息
----删除库存信息
DELETE FROM WM_STORAGE;
UPDATE WM_Pallet SET MatchPalletCode='', MatchPalletName='',UniqueId='',ProductCount=0,StorageQuantity=0,InFrozenQuantity=0,OutFrozenQuantity=0
      ,ProductPosition='',BrandCodes='',BrandNames='',PalletTypeCode='',PalletTypeName='';
----清除货位产品预设信息
UPDATE WM_Location SET PresetProductCode=NULL,PresetProductName=NULL;
----清除产品信息
--DELETE FROM BI_Unit;
DELETE FROM BI_ProductUnit;
DELETE FROM BI_Product;
DELETE FROM BI_Model;
----删除入库单据信息
DELETE FROM WM_InBillAllot;
DELETE FROM WM_InBillDetail;
DELETE FROM WM_InBill;
----删除出库单据信息
DELETE FROM WM_OutBillAllot;
DELETE FROM WM_OutBillDetail;
DELETE FROM WM_OutBill;
--*/

/*清除数据后，更方便调整字段编码了
--初始柜号是从01-05<=>编号01-05，架号是01-14<=>编号05-19
ALTER TABLE WM_Pallet NOCHECK CONSTRAINT FK_5FF3F9E95E5EA9DC1F02634C;
--下三条update只能执行一遍
update WM_Pallet SET LocationCode=(cast(cast(SUBSTRING(LocationCode,1,2) as int)+18 as nvarchar)	
		+SUBSTRING(LocationCode,3,19)) 
	WHERE LEN(LocationCode)>2 and cast(substring(LocationCode,1,2) as int)>=1 and cast(substring(LocationCode,1,2) as int)< 5;
update WM_Pallet SET LocationCode=(RIGHT(replicate('0', 1)+cast(cast(SUBSTRING(LocationCode,1,2) as int)-4 as nvarchar), 2)
		+SUBSTRING(LocationCode,3,19)) 
	WHERE LEN(LocationCode)>2 and cast(substring(LocationCode,1,2) as int)>=5 and cast(substring(LocationCode,1,2) as int)<19;
UPDATE WM_Location SET LocationCode=(cast(cast(SUBSTRING(LocationName,1,2) as int)+18 as nvarchar)+SUBSTRING(LocationCode,3,19))
	, ShelfCode= 'ACS001R01-'+SUBSTRING(LocationName,1,2)
	WHERE LocationName LIKE '01柜-%' OR LocationName LIKE '02柜-%' OR LocationName LIKE '03柜-%' OR LocationName LIKE '04柜-%';
--SELECT * FROM WM_Location WHERE LocationName LIKE '01柜-%' OR LocationName LIKE '02柜-%' OR LocationName LIKE '03柜-%' OR LocationName LIKE '04柜-%';
--SELECT (cast(cast(SUBSTRING(LocationName,1,2) as int)+18 as nvarchar)
--		+SUBSTRING(LocationCode,3,19)) 
--	FROM WM_Location WHERE LocationName LIKE '01柜-%' OR LocationName LIKE '02柜-%' OR LocationName LIKE '03柜-%' OR LocationName LIKE '04柜-%';

update WM_Shelf SET ShelfCode='LS-'+SUBSTRING(ShelfName,1,2) WHERE ShelfName LIKE '%人工货架';
--SELECT * FROM WM_Shelf WHERE ShelfName LIKE '%人工货架';
UPDATE WM_Location SET LocationCode=(RIGHT(replicate('0', 2)+cast(cast(SUBSTRING(LocationName,1,2) as int) as nvarchar), 2)
			+SUBSTRING(LocationCode,3,19))
		,ShelfCode='LS-'+SUBSTRING(LocationName,1,2)
		WHERE LocationName LIKE '%架-%';
ALTER TABLE WM_Pallet CHECK CONSTRAINT FK_5FF3F9E95E5EA9DC1F02634C;
--SELECT * FROM WM_Location WHERE LocationName LIKE '%架-%';
--*/