
/*--����λ���������ɺ��������Ƶ�
----ɾ�������Ϣ
DELETE FROM WM_STORAGE;
UPDATE WM_Pallet SET MatchPalletCode='', MatchPalletName='',UniqueId='',ProductCount=0,StorageQuantity=0,InFrozenQuantity=0,OutFrozenQuantity=0
      ,ProductPosition='',BrandCodes='',BrandNames='',PalletTypeCode='',PalletTypeName='';
----ɾ����ⵥ����Ϣ
DELETE FROM WM_InBillAllot;
DELETE FROM WM_InBillDetail;
DELETE FROM WM_InBill;
----ɾ�����ⵥ����Ϣ
DELETE FROM WM_OutBillAllot;
DELETE FROM WM_OutBillDetail;
DELETE FROM WM_OutBill;

--��ʼ����Ǵ�01-05<=>���01-05���ܺ���01-14<=>���05-19
ALTER TABLE WM_Pallet NOCHECK CONSTRAINT FK_5FF3F9E95E5EA9DC1F02634C;
--������updateֻ��ִ��һ��
update WM_Pallet SET LocationCode=(cast(cast(SUBSTRING(LocationCode,1,2) as int)+18 as nvarchar)	
		+SUBSTRING(LocationCode,3,19)) 
	WHERE LEN(LocationCode)>2 and cast(substring(LocationCode,1,2) as int)>=1 and cast(substring(LocationCode,1,2) as int)< 5;
update WM_Pallet SET LocationCode=(RIGHT(replicate('0', 1)+cast(cast(SUBSTRING(LocationCode,1,2) as int)-4 as nvarchar), 2)
		+SUBSTRING(LocationCode,3,19)) 
	WHERE LEN(LocationCode)>2 and cast(substring(LocationCode,1,2) as int)>=5 and cast(substring(LocationCode,1,2) as int)<19;
UPDATE WM_Location SET LocationCode=(cast(cast(SUBSTRING(LocationName,1,2) as int)+18 as nvarchar)
		+SUBSTRING(LocationCode,3,19)) 
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
----******�������߼�*****----
--һ��׼�������ݣ�sql�����ļ�"��Ӧ���ݿ������������ֶλ���"��
--����ͨ������ƴ���ַ�����ȡ������߸���sql�����������ݱ���
--��������ȡ��sqlͨ��dbo.f_PlaceHolderStrת������Ŀ�����ݿ���ִ��
----******//////////*****----
DELETE FROM TL_ExecuteSql;
Declare @insertStr nvarchar(200)='INSERT [dbo].[BI_Unit]([UnitCode], [UnitName], [TransferRate], [Active], [CreateTime], [UpdateTime], [RowVersion])';
	+ 'VALUES (''@1'', ''@2'', 1, ''True'', SYSDATETIME(), SYSDATETIME(), NEWID());';
INSERT INTO TL_ExecuteSql(CombineSql,Param01,Param02) SELECT @insertStr+@insertValue, UnitCode, UnitName from TB01;

set @insertStr ='INSERT [dbo].[BI_Product]([ProductCode], [ProductName], [ProductNo], [FullPhoneticize], [ShortPhoneticize], [DisplayOrder], [UniformCode], [FacturerCode]'
	+ ', [CargoOwnerCode], [ModelCode], [PackType], [Abnormity], [Length], [Width], [Height], [Active], [IsBigProduct], [SortNo], [Remark], [ProductCategoryCode], [ProductBreedCode]'
	+ ', [ProductPatternCode], [ProductGradeCode], [ProductOriginCode], [Year], [Weight], [CreateTime], [UpdateTime], [RowVersion])';
	+ '	VALUES (''@1'', ''@2'', 0, ''@2'', ''@2'', 0, '''', '''', NULL, '''', 0, ''False'', 0, 0, 0, ''True'', ''False'', 0, '''', '''', '''', '''', '''', '''', '''''
	+ ', ''0'', SYSDATETIME(), SYSDATETIME(), NEWID());';
INSERT INTO TL_ExecuteSql(CombineSql,Param01,Param02) SELECT @insertStr+@insertValue, ProductCode, ProductName from TB01;

set @insertStr ='INSERT [dbo].[BI_ProductUnit]([Id], [ProductCode], [UnitCode], [UnitName], [UnitType], [TransferRate], [Active], [DefaultUnit], [CreateTime], [UpdateTime], [RowVersion])'
	+ '	select case when count(ProductCode)=0 then newid() else min(Id) end '
	+ '		, ''@1'', ''@2'', ''@3'', 1, 1, ''True'', ''True'', SYSDATETIME(), SYSDATETIME(), NEWID()'
	+ '	FROM BI_ProductUnit WHERE ProductCode=''@1'' group by ProductCode;';
INSERT INTO TL_ExecuteSql(CombineSql,Param01,Param02,Param03) SELECT @insertStr, ProductCode, UnitCode, UnitName from TB01;

set @insertStr ='INSERT [dbo].[BI_ProductUnit]([Id], [ProductCode], [UnitCode], [UnitName], [UnitType], [TransferRate], [Active], [DefaultUnit], [CreateTime], [UpdateTime], [RowVersion])'
	+ '	select case when count(ProductCode)=0 then newid() else min(Id) end '
	+ '		, ''@1'', ''@2'', ''@3'', 1, 1, ''True'', ''True'', SYSDATETIME(), SYSDATETIME(), NEWID()'
	+ '	FROM BI_ProductUnit WHERE ProductCode=''@1'' group by ProductCode;';
INSERT INTO TL_ExecuteSql(CombineSql,Param01,Param02,Param03) SELECT @insertStr, ProductCode, UnitCode, UnitName from TB01;
----�������Ӧ��pallet
set @insertStr ='UPDATE [dbo].[WM_Pallet] SET [ProductCount] = 1, StorageQuantity=''@1'' WHERE [LocationCode] = ''@2'';'
INSERT INTO TL_ExecuteSql(CombineSql,Param01,Param02) SELECT @insertStr, Quantity, LocationCode from TB01;



/*--��ǰ����׼���ò�Ʒ��λ<==���ݶ��ظ������Էֵ������ļ�ִ��
INSERT [dbo].[BI_Unit]([UnitCode], [UnitName], [TransferRate], [Active], [CreateTime], [UpdateTime], [RowVersion])
	VALUES ('201', '��', 1, 'True', SYSDATETIME(), SYSDATETIME(), NEWID());

--��ǰ����׼���ò�Ʒ������Ϣ<==���ݶ��ظ������Էֵ������ļ�ִ��
INSERT [dbo].[BI_Product]([ProductCode], [ProductName], [ProductNo], [FullPhoneticize], [ShortPhoneticize], [DisplayOrder], [UniformCode], [FacturerCode], [CargoOwnerCode], [ModelCode], [PackType], [Abnormity], [Length], [Width], [Height], [Active], [IsBigProduct], [SortNo], [Remark], [ProductCategoryCode], [ProductBreedCode], [ProductPatternCode], [ProductGradeCode], [ProductOriginCode], [Year], [Weight], [CreateTime], [UpdateTime], [RowVersion])
	VALUES ('00604600048', '����', 0, '����', '����', 0, '', '', NULL, '', 0, 'False', 0, 0, 0, 'True', 'False', 0, '', '', '', '', '', '', '', '0', CONVERT(datetime, '2021/7/10 10:02:56', 101), CONVERT(datetime, '2021/7/10 10:02:56', 101), NEWID());

--��ǰ����׼���ò�Ʒ��λ��Ϣ<==���ݶ��ظ������Էֵ������ļ�ִ��
INSERT [dbo].[BI_ProductUnit]([Id], [ProductCode], [UnitCode], [UnitName], [UnitType], [TransferRate], [Active], [DefaultUnit], [CreateTime], [UpdateTime], [RowVersion])
	select case when count(ProductCode)=0 then newid() else min(Id) end 
		, '00604600048', '201', '��', 1, 1, 'True', 'True', CONVERT(datetime, '2021/7/10 10:33:53', 101), CONVERT(datetime, '2021/7/10 10:33:53', 101), NEWID()
	FROM BI_ProductUnit WHERE ProductCode='00604600048' group by ProductCode;
--*/

/*����Ʒ��ӽ��������������sql
-----ֻ��ִ��һ��
--INSERT [dbo].[WM_InBill]([InBillNo], [OriginBillNo], [BillTypeCode], [WarehouseCode], [Maker], [MakeTime], [Auditor], [AuditTime], [BoxNos], [StationCode], [InBatch], [CargoOwnerCode], [CargoOwnerName], [ContractNo], [UserDefine], [PassCode], [InBillStatus], [InBillOrigin], [BrandCode], [BrandName], [Frozen], [Remark], [CreateTime], [UpdateTime], [RowVersion])
--	VALUES ('I202107090001', '', '102', 'MDJ-BJK', 'admin', CONVERT(datetime, '2021/7/9 15:18:00', 101), '', NULL, '', '', '', '', '', '', '', '', 0, 0, NULL, NULL, 'False', '', CONVERT(datetime, '2021/7/9 15:18:00', 101), CONVERT(datetime, '2021/7/9 15:18:00', 101), NEWID());
--DECLARE @DetailId nvarchar(80);
--set @DetailId=NEWID();
------��ִ��N�Σ���INSERT [WM_InBillAllot]��һ��sqlִ��
--INSERT [dbo].[WM_InBillDetail]([Id], [InBillNo], [SerialNumber], [ProductCode], [ProductName], [UnitCode], [UnitName], [TransferRate], [ProductYear], [MakeQuantity], [AllotQuantity], [RealQuantity], [DefaultWeight], [ActualWeight], [CreateTime], [UpdateTime], [RowVersion])
--	VALUES (@DetailId, 'I202107090001', 1, '00604600048', '����', '201', '��', 1, '', '1', '0', '0', '0', NULL, CONVERT(datetime, '2021/7/9 15:18:12', 101), CONVERT(datetime, '2021/7/9 15:18:12', 101), NEWID());

------��ִ��N�Σ�������һ��sqlִ��
--INSERT [dbo].[WM_InBillAllot]([Id], [InBillNo], [SerialNumber], [InBillDetailId], [ProductCode], [ProductName], [ProductYear], [Barcodes], [Sampling], [UnitCode], [UnitName], [TransferRate], [InWorkPositionNo], [LocationCode], [PalletId], [StorageId], [AllotQuantity], [RealQuantity], [Operator], [InBillAllotStatus], [BoxNos], [StartTime], [FinishTime], [Reserve], [CreateTime], [UpdateTime], [RowVersion])
--	VALUES (NEWID(), 'I202107090001', 1, @DetailId, '00604600048', '����', '', '', 'False', '201', '��', 1, NULL, '01-01-01', '41353de9-816f-45da-88c5-9e4bbb6a715b', '95c4c187-8771-45aa-ae36-ee2b4df4f270', '1.00', '0', NULL, 0, NULL, NULL, NULL, NULL, CONVERT(datetime, '2021/7/9 15:18:31', 101), CONVERT(datetime, '2021/7/9 15:18:31', 101), NEWID())

--INSERT [dbo].[SYS_Parameter]([Id], [Name], [ParameterName], [ParameterValue], [GroupName], [DisplayOrder], [Description], [ParameterValueType], [DictionaryKey], [CreateTime], [UpdateTime], [RowVersion])
--VALUES ('58c30595-c408-41eb-b0d8-5ff1244510b2', 'onlyStorageRecord', 'onlyStorageRecord', 'False', 'δ����', 0, NULL, 2, '', CONVERT(datetime, '2021/7/9 15:18:31', 101), CONVERT(datetime, '2021/7/9 15:18:31', 101), NEWID())
UPDATE [dbo].[WM_Pallet] SET [ProductCount] = 1, StorageQuantity='1.00' WHERE [LocationCode] = '01-01-01';
INSERT [dbo].[WM_Storage]([Id], [PalletId], [LocationCode], [ProductCode], [ProductName], [ProductYear], [Barcodes], [BoxNos], [Sampling], [StorageQuantity], [StorageTime], [InFrozenQuantity], [OutFrozenQuantity], [FreezeBillNos], [LockTag], [IdentityTag], [UnlockTag], [CargoOwnerCode], [CargoOwnerName], [UserDefine], [InBatch], [InBillNo], [WorkOrder], [ColorCode], [ColorName], [SizeCode], [SizeName], [SmallBarcodes], [FacturerCode], [FacturerName], [Weight], [Direction], [Remark], [ProducedDate], [CreateTime], [UpdateTime], [RowVersion])
	VALUES (NEWID(), (SELECT Top 1 Id FROM WM_Pallet where LocationCode='01-01-01'), '01-01-01', '00604600048', '����', '', '', '', 'False', '1.00', SYSDATETIME()
	, '0', '0', '', '', NULL, NULL, '', '', '', '', 'I202107090001', '', '', '', '', '', '', '', '', '0', 0, '', NULL, SYSDATETIME(), SYSDATETIME(), NEWID());
--SELECT Top 1 * FROM WM_Pallet WHERE (1=1);
--SELECT * FROM WM_Location WHERE LocationCode='01-01-01';
--*/