use [FusionBJK]
--/*--����λ���������ɺ��������Ƶģ���ΪҪ����ͬ�����ݣ�����ɾ�������Ϣ��һЩ���������Ϣ
----ɾ�������Ϣ
DELETE FROM WM_STORAGE;
UPDATE WM_Pallet SET MatchPalletCode='', MatchPalletName='',UniqueId='',ProductCount=0,StorageQuantity=0,InFrozenQuantity=0,OutFrozenQuantity=0
      ,ProductPosition='',BrandCodes='',BrandNames='',PalletTypeCode='',PalletTypeName='';
----�����λ��ƷԤ����Ϣ
UPDATE WM_Location SET PresetProductCode=NULL,PresetProductName=NULL;
----�����Ʒ��Ϣ
--DELETE FROM BI_Unit;
DELETE FROM BI_ProductUnit;
DELETE FROM BI_Product;
DELETE FROM BI_Model;
----ɾ����ⵥ����Ϣ
DELETE FROM WM_InBillAllot;
DELETE FROM WM_InBillDetail;
DELETE FROM WM_InBill;
----ɾ�����ⵥ����Ϣ
DELETE FROM WM_OutBillAllot;
DELETE FROM WM_OutBillDetail;
DELETE FROM WM_OutBill;
--*/

/*������ݺ󣬸���������ֶα�����
--��ʼ����Ǵ�01-05<=>���01-05���ܺ���01-14<=>���05-19
ALTER TABLE WM_Pallet NOCHECK CONSTRAINT FK_5FF3F9E95E5EA9DC1F02634C;
--������updateֻ��ִ��һ��
update WM_Pallet SET LocationCode=(cast(cast(SUBSTRING(LocationCode,1,2) as int)+18 as nvarchar)	
		+SUBSTRING(LocationCode,3,19)) 
	WHERE LEN(LocationCode)>2 and cast(substring(LocationCode,1,2) as int)>=1 and cast(substring(LocationCode,1,2) as int)< 5;
update WM_Pallet SET LocationCode=(RIGHT(replicate('0', 1)+cast(cast(SUBSTRING(LocationCode,1,2) as int)-4 as nvarchar), 2)
		+SUBSTRING(LocationCode,3,19)) 
	WHERE LEN(LocationCode)>2 and cast(substring(LocationCode,1,2) as int)>=5 and cast(substring(LocationCode,1,2) as int)<19;
UPDATE WM_Location SET LocationCode=(cast(cast(SUBSTRING(LocationName,1,2) as int)+18 as nvarchar)+SUBSTRING(LocationCode,3,19))
	, ShelfCode= 'ACS001R01-'+SUBSTRING(LocationName,1,2)
	WHERE LocationName LIKE '01��-%' OR LocationName LIKE '02��-%' OR LocationName LIKE '03��-%' OR LocationName LIKE '04��-%';
--SELECT * FROM WM_Location WHERE LocationName LIKE '01��-%' OR LocationName LIKE '02��-%' OR LocationName LIKE '03��-%' OR LocationName LIKE '04��-%';
--SELECT (cast(cast(SUBSTRING(LocationName,1,2) as int)+18 as nvarchar)
--		+SUBSTRING(LocationCode,3,19)) 
--	FROM WM_Location WHERE LocationName LIKE '01��-%' OR LocationName LIKE '02��-%' OR LocationName LIKE '03��-%' OR LocationName LIKE '04��-%';

update WM_Shelf SET ShelfCode='LS-'+SUBSTRING(ShelfName,1,2) WHERE ShelfName LIKE '%�˹�����';
--SELECT * FROM WM_Shelf WHERE ShelfName LIKE '%�˹�����';
UPDATE WM_Location SET LocationCode=(RIGHT(replicate('0', 2)+cast(cast(SUBSTRING(LocationName,1,2) as int) as nvarchar), 2)
			+SUBSTRING(LocationCode,3,19))
		,ShelfCode='LS-'+SUBSTRING(LocationName,1,2)
		WHERE LocationName LIKE '%��-%';
ALTER TABLE WM_Pallet CHECK CONSTRAINT FK_5FF3F9E95E5EA9DC1F02634C;
--SELECT * FROM WM_Location WHERE LocationName LIKE '%��-%';
--*/