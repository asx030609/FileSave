use [TestDB]
----******�������߼�*****----
--һ��׼�������ݣ�sql�����ļ�"��Ӧ���ݿ������������ֶλ���"��
--����ͨ������ƴ���ַ�����ȡ������߸���sql�����������ݱ���
--��������ȡ��sqlͨ��dbo.f_PlaceHolderStrת������Ŀ�����ݿ���ִ��--���磬SELECT dbo.f_PlaceHolderStr(CombineSql,Param01,Param02,Param03,Param04,Param05) FROM TL_ExecuteSql ORDER BY ID;
----*********************----

DELETE FROM TL_ExecuteSql;
----����BI_Unit
Declare @insertStr nvarchar(1000)='INSERT [dbo].[BI_Unit]([UnitCode], [UnitName], [TransferRate], [Active], [CreateTime], [UpdateTime], [RowVersion])'
	+ 'VALUES (''@1'', ''@2'', 1, ''True'', SYSDATETIME(), SYSDATETIME(), NEWID());';
INSERT INTO TL_ExecuteSql(CombineSql,Param01,Param02,TaskType,CreateTime) SELECT @insertStr, UnitCode, UnitName,1,SysdateTime() from TB01 Group by UnitCode,UnitName;
----����BI_Model
SET @insertStr= 'INSERT [dbo].[BI_Model]([ModelCode], [ModelName], [Active], [Remark], [CreateTime], [UpdateTime], [RowVersion])'
	+ 'VALUES (''@1'', ''@2'', ''True'', '''', SYSDATETIME(), SYSDATETIME(), NEWID());';
INSERT INTO TL_ExecuteSql(CombineSql,Param01,Param02,TaskType,CreateTime) SELECT @insertStr,ModelCode, Model,21,SYSDATETIME() from TB01 where Model is not null Group by ModelCode, Model;
----����BI_Product
set @insertStr ='INSERT [dbo].[BI_Product]([ProductCode], [ProductName], [ProductNo], [FullPhoneticize], [ShortPhoneticize], [DisplayOrder], [UniformCode], [FacturerCode]'
	+ ', [CargoOwnerCode], [ModelCode], [PackType], [Abnormity], [Length], [Width], [Height], [Active], [IsBigProduct], [SortNo], [Remark], [ProductCategoryCode], [ProductBreedCode]'
	+ ', [ProductPatternCode], [ProductGradeCode], [ProductOriginCode], [Year], [Weight], [CreateTime], [UpdateTime], [RowVersion])'
	+ '	VALUES (''@1'', ''@2'', 0, ''@2'', ''@2'', 0, '''', '''', NULL, '''', 0, ''False'', 0, 0, 0, ''True'', ''False'', 0, '''', '''', '''', '''', '''', '''', '''''
	+ ', ''0'', SYSDATETIME(), SYSDATETIME(), NEWID());';
INSERT INTO TL_ExecuteSql(CombineSql,Param01,Param02,TaskType,CreateTime) SELECT @insertStr, ProductCode, ProductName,31,SYSDATETIME() from TB01 Group by ProductCode,ProductName;
----����BI_ProductUnit
set @insertStr ='INSERT [dbo].[BI_ProductUnit]([Id], [ProductCode], [UnitCode], [UnitName], [UnitType], [TransferRate], [Active], [DefaultUnit], [CreateTime], [UpdateTime], [RowVersion])'
	+ '	values (''@1'', ''@2'', ''@3'', ''@4'', 1, @5, ''True'', ''True'', SYSDATETIME(), SYSDATETIME(), NEWID());';
--print(@insertStr);
INSERT INTO TL_ExecuteSql(CombineSql,Param01,Param02,Param03,Param04,Param05,TaskType,CreateTime) SELECT @insertStr,ProductUnitId, ProductCode, UnitCode, UnitName,[Transfer],41,SYSDATETIME() 
	from TB01 Group by ProductUnitId, ProductCode, UnitCode, UnitName,[Transfer];
--/*
SET @insertStr = 'UPDATE [dbo].[WM_Location] SET [PresetProductCode] = ''@1'' WHERE [LocationCode] = ''@2'';';
INSERT INTO TL_ExecuteSql(CombineSql,Param01,Param02,TaskType,CreateTime) SELECT @insertStr, ProductCode, LocationCode,51,SYSDATETIME() from TB01 where LocationName like '%��%';
----���¿���Ӧ��pallet
set @insertStr ='UPDATE [dbo].[WM_Pallet] SET [ProductCount] = ProductCount+1, StorageQuantity=StorageQuantity+@1 WHERE [LocationCode] = ''@2'';';
INSERT INTO TL_ExecuteSql(CombineSql,Param01,Param02,TaskType,CreateTime) SELECT @insertStr, Quantity*[Transfer], LocationCode,61,SYSDATETIME() from TB01;
----�������Ӧ��storage
set @insertStr ='INSERT [dbo].[WM_Storage]([Id], [PalletId], [LocationCode], [ProductCode], [ProductName], [ProductYear], [Barcodes], [BoxNos], [Sampling], [StorageQuantity], [StorageTime]'
	+ ', [InFrozenQuantity], [OutFrozenQuantity], [FreezeBillNos], [LockTag], [IdentityTag], [UnlockTag], [CargoOwnerCode], [CargoOwnerName], [UserDefine], [InBatch], [InBillNo]'
	+ ', [WorkOrder], [ColorCode], [ColorName], [SizeCode], [SizeName], [SmallBarcodes], [FacturerCode], [FacturerName], [Weight], [Direction], [Remark], [ProducedDate], [CreateTime], [UpdateTime]'
	+ ', [RowVersion])'
	+ '	VALUES (NEWID(), (SELECT Top 1 Id FROM WM_Pallet where LocationCode=''@1''), ''@1'', ''@2'', ''@3'', '''', '''', '''', ''False'', @4, SYSDATETIME()'
	+ '	, ''0'', ''0'', '''', '''', NULL, NULL, '''', '''', '''', '''', '''', '''', '''', '''', '''', '''', '''', '''', '''', ''0'', 0, '''', NULL, SYSDATETIME(), SYSDATETIME(), NEWID());'
INSERT INTO TL_ExecuteSql(CombineSql,Param01,Param02,Param03,Param04,TaskType,CreateTime) SELECT @insertStr, LocationCode,ProductCode,ProductName,Quantity*[Transfer],71,SYSDATETIME() from TB01
	;
--*/

GO
/*--��ǰ����׼���ò�Ʒ��λ<==���ݶ��ظ������Էֵ������ļ�ִ��
INSERT [dbo].[BI_Unit]([UnitCode], [UnitName], [TransferRate], [Active], [CreateTime], [UpdateTime], [RowVersion])
	VALUES ('201', '��', 1, 'True', SYSDATETIME(), SYSDATETIME(), NEWID());

--��ǰ����BI_MODEL
INSERT [dbo].[BI_Model]([ModelCode], [ModelName], [Active], [Remark], [CreateTime], [UpdateTime], [RowVersion])
	VALUES ('tEST', 'TEST', 'True', '', SYSDATETIME(), SYSDATETIME(), NEWID());

--��ǰ����׼���ò�Ʒ������Ϣ<==���ݶ��ظ������Էֵ������ļ�ִ��
INSERT [dbo].[BI_Product]([ProductCode], [ProductName], [ProductNo], [FullPhoneticize], [ShortPhoneticize], [DisplayOrder], [UniformCode], [FacturerCode], [CargoOwnerCode], [ModelCode]
		, [PackType], [Abnormity], [Length], [Width], [Height], [Active], [IsBigProduct], [SortNo], [Remark], [ProductCategoryCode], [ProductBreedCode], [ProductPatternCode]
		, [ProductGradeCode], [ProductOriginCode], [Year], [Weight], [CreateTime], [UpdateTime], [RowVersion])
	VALUES ('00604600048', '����', 0, '����', '����', 0, '', '', NULL, 'ͼ��790398', 0, 'False', 0, 0, 0, 'True', 'False', 0, '', '', '', '', '', '', '', '0', SYSDATETIME(),SYSDATETIME(), NEWID());

--��ǰ����׼���ò�Ʒ��λ��Ϣ<==���ݶ��ظ������Էֵ������ļ�ִ��
INSERT [dbo].[BI_ProductUnit]([Id], [ProductCode], [UnitCode], [UnitName], [UnitType], [TransferRate], [Active], [DefaultUnit], [CreateTime], [UpdateTime], [RowVersion])
	values ('unitId', '00604600048', '201', '��', 1, 1, 'True', 'True', SYSDATETIME(), SYSDATETIME(), NEWID());
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
	VALUES (NEWID(), (SELECT Top 1 Id FROM WM_Pallet where LocationCode='01-01-01'), '01-01-01', '00604600048', '����', '', '', '', 'False', 1.00, SYSDATETIME()
	, '0', '0', '', '', NULL, NULL, '', '', '', '', 'I202107090001', '', '', '', '', '', '', '', '', '0', 0, '', NULL, SYSDATETIME(), SYSDATETIME(), NEWID());
--SELECT Top 1 * FROM WM_Pallet WHERE (1=1);
--SELECT * FROM WM_Location WHERE LocationCode='01-01-01';
--*/
GO