use [Fusion_LuoYangFLK]
--删除库存及所有表单信息
delete from WM_STORAGE;

--删除仓库实体信息
delete from WM_Pallet;
delete from WM_Location;
delete from WM_Shelf;
delete from WM_Region;
delete from WM_Warehouse;
--删除仓库作业位置信息
delete from TM_OperationEquipment;
delete from TM_WorkPosition;
delete from TM_WorkRegion;
--删除一键生成数据的配置信息
delete from SYS_DBInitialize;
delete from SYS_WarehouseConfig;
--添加仓库信息
INSERT [dbo].[WM_Warehouse] ([WarehouseCode], [WarehouseName], [DisplayOrder], [WarehouseType], [Active], [Remark]
	, [CreateTime], [UpdateTime], [RowVersion]) VALUES (N'w002', N'LYYC_FLK', 1, 0, 1, N''
	, GETDATE(), GETDATE(), 0xD95CBE2C15FFA341B8E781B846ECA645);
GO
--添加区域
INSERT [dbo].[WM_Region] ([WarehouseCode], [RegionCode], [RegionName], [DisplayOrder], [RegionType], [AllotInOrder]
	, [AllotOutOrder], [Active], [ExternalRegionCode], [Remark], [CreateTime], [UpdateTime], [RowVersion]) 
	VALUES (N'w002', N'w002r01', N'辅料库区', 1, 0, 0, 0, 1, N'', N'',  GETDATE()
	, GETDATE(), 0xA469C885C22F764AB8B95F59F1DE2F9D);
GO
--添加货架

--仓库和区域都添加完成后，使用的是网页上的系统管理>工具>初始化数据中的一键配置功能，其中配置涉及到的参数如下
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
VALUES (NEWID(), @DBInit_id, N'仓库配置001', 1, N'w002', N'w002r01'
	, N'w002r01-{0}', 4, 32, 3, 2, 2, 2, 1, 1, 1, N'{1}-{2}-{0}', N'{1}排-{2}列-{0}层', N'{1}{2}{0}', N'{1}排{2}列{0}层', N'r-srm{0}'
	, N'{0}号堆垛机区', 2, 1, N'srm{0}', N'{0}号堆垛机', 2, 1, 2, 1, 1, 0, GETDATE()
	, GETDATE(), cast('10' as varbinary));

--添加辅料入库站台2101相关的站台和作业位置


select * from WM_Warehouse;
--添加区域
select * from WM_Region;
--添加货架
select * from WM_Shelf;
--添加货位
select * from WM_Location;
select * from WM_Pallet;