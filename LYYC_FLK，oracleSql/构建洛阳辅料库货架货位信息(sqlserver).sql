use [Fusion_LuoYangFLK]
--ɾ����漰���б���Ϣ
delete from WM_STORAGE;

--ɾ���ֿ�ʵ����Ϣ
delete from WM_Pallet;
delete from WM_Location;
delete from WM_Shelf;
delete from WM_Region;
delete from WM_Warehouse;
--ɾ���ֿ���ҵλ����Ϣ
delete from TM_OperationEquipment;
delete from TM_WorkPosition;
delete from TM_WorkRegion;
--ɾ��һ���������ݵ�������Ϣ
delete from SYS_DBInitialize;
delete from SYS_WarehouseConfig;
--��Ӳֿ���Ϣ
INSERT [dbo].[WM_Warehouse] ([WarehouseCode], [WarehouseName], [DisplayOrder], [WarehouseType], [Active], [Remark]
	, [CreateTime], [UpdateTime], [RowVersion]) VALUES (N'w002', N'LYYC_FLK', 1, 0, 1, N''
	, GETDATE(), GETDATE(), 0xD95CBE2C15FFA341B8E781B846ECA645);
GO
--�������
INSERT [dbo].[WM_Region] ([WarehouseCode], [RegionCode], [RegionName], [DisplayOrder], [RegionType], [AllotInOrder]
	, [AllotOutOrder], [Active], [ExternalRegionCode], [Remark], [CreateTime], [UpdateTime], [RowVersion]) 
	VALUES (N'w002', N'w002r01', N'���Ͽ���', 1, 0, 0, 0, 1, N'', N'',  GETDATE()
	, GETDATE(), 0xA469C885C22F764AB8B95F59F1DE2F9D);
GO
--��ӻ���

--�ֿ�����������ɺ�ʹ�õ�����ҳ�ϵ�ϵͳ����>����>��ʼ�������е�һ�����ù��ܣ����������漰���Ĳ�������
declare @DBInit_id nvarchar(50);
set @DBInit_id = NEWID();
INSERT INTO [dbo].[SYS_DBInitialize] ([Id] ,[InitializeName] ,[CreateTime] ,[UpdateTime] ,[RowVersion]) VALUES 
	(@DBInit_id, 'LYYC_FLK', GETDATE(), GETDATE(), cast('10' as varbinary));
INSERT [dbo].[SYS_WarehouseConfig] ([Id], [DBInitializId], [WarehouseConfigName], [GenerateOrder], [WarehouseCode], [RegionCode]
	, [ShelfCodeFormat], [ShelfLayerCount], [ShelfColumnCount], [ShelfRowCount], [ShelfLayerCodeWidth], [ShelfColumnCodeWidth]
	, [ShelfRowCodeWidth], [ShelfLayerStart], [ShelfColumnStart], [ShelfRowStart], [LocationCodeFormat], [LocationNameFormat]
	, [WorkPositionNoFormat], [WorkPositionNameFormat], [WorkRegionCodeFormat], [WorkRegionNameFormat], [WorkRegionCount], [WorkRegionStart]
	, [WorkEquipmentCodeFormat], [WorkEquipmentNameFormat], [WorkEquipmentCount], [WorkEquipmentStart], [EquipmentControlShelftRowCount]
	, [Active], [IsGenerateWorkPosition], [EquipmentIsReverseControlShelf], [CreateTime], [UpdateTime], [RowVersion]) 
VALUES (NEWID(), @DBInit_id, N'�ֿ�����001', 1, N'w002', N'w002r01'
	, N'w002r01-{0}', 4, 32, 3, 2, 2, 2, 1, 1, 1, N'{1}-{2}-{0}', N'{1}��-{2}��-{0}��', N'{1}{2}{0}', N'{1}��{2}��{0}��', N'r-srm{0}'
	, N'{0}�ŶѶ����', 2, 1, N'srm{0}', N'{0}�ŶѶ��', 2, 1, 2, 1, 1, 0, GETDATE()
	, GETDATE(), cast('10' as varbinary));

--��Ӹ������վ̨2101��ص�վ̨����ҵλ��


select * from WM_Warehouse;
--�������
select * from WM_Region;
--��ӻ���
select * from WM_Shelf;
--��ӻ�λ
select * from WM_Location;
select * from WM_Pallet;