
USE [FusionBJK]
GO
if exists(select * from dbo.sysobjects where id=object_id(N'pro_001') and OBJECTPROPERTY(id, N'IsProcedure')=1)	--或者使用select * from dbo.sysobjects where xtype='P';？
	drop procedure pro_001;
go
----正常情况下是一柜一层最多32位，但是用友上尽然可以到58
----1-N柜，1-M层，N、M已经固定，要在这固定的基础上添加33-58位
----找出N、M
create PROC pro_001
AS
BEGIN
	Declare @v_Jia nvarchar(20);
	Declare @v_Layer nvarchar(20);
	Declare @v_Place nvarchar(20);
	Declare @i_EndJia int = 21;	--先假设每架每层都是固定那么多数，这样好批量增加，不更复杂化了
	Declare @i_EndLayer int = 65;
	Declare @i_EndPlace int = 99;
	Declare @i_BeginJia int = 19;
	Declare @i_BeginLayer int = 1;
	Declare @i_BeginPlace int = 33;

	Declare @i_Jia int = 1;
	Declare @i_Layer int = 1;
	Declare @i_Place int = 1;
	Declare @v_LocationCode nvarchar(50);
	set @i_Jia=@i_BeginJia;
	while(@i_Jia <= @i_EndJia)
	begin
		set @v_Jia = Right('0'+ cast(@i_Jia as nvarchar),2);
		set @i_Layer=@i_BeginLayer;
		while(@i_Layer <= @i_EndLayer)
		begin
			set @v_Layer = Right('0'+cast(@i_Layer as nvarchar), 2);
			set @i_Place = @i_BeginPlace;
			while(@i_Place <= @i_EndPlace)
			begin
				set @v_Place = Right('0'+cast(@i_Place as nvarchar), 2);
				--print(@v_Jia+'-'+@v_Layer+'-'+@v_Place);
				set @v_LocationCode = @v_Jia+'-'+@v_Layer+'-'+@v_Place;
				Declare @v_LocationName nvarchar(80) = @v_Jia+'柜'+@v_Layer+'层'+@v_Place+'位';
				Declare @i_Pallet int = 1;
				DELETE FROM WM_Pallet WHERE LocationCode=@v_LocationCode;
				DELETE FROM WM_Location WHERE LocationCode=@v_LocationCode;
				INSERT [dbo].[WM_Location]([LocationCode], [LocationName], [LocationType], [WarehouseCode], [RegionCode], [ShelfCode], [PresetProductCode]
					, [PresetProductName], [InPositionNo], [OutPositionNo], [InWorkEquipmentCodes], [OutWorkEquipmentCodes], [PalletMaxReserves]
					, [MaxPalletQuantity], [OutStrategy], [OutAllotStrategy], [DisplayOrder], [AllotInOrder], [LocationRfid], [LocationLayer]
					, [LocationColumn], [CoordinateX], [CoordinateY], [LocationStatus], [FrontEquipmentCodes], [RearEquipmentCodes], [FrontPosition]
					, [RearPosition], [LockTag], [Remark], [CreateTime], [UpdateTime], [RowVersion], [EquipmentUsed], [PositionUsed])
				VALUES (@v_LocationCode, @v_LocationName, 0, 'MDJ-BJK', 'ACS', 'ACS001R01-'+@v_Jia, '', '', 0, 0, null, null, 5000, 1, 0, 0
					, 2164, 2080, '', @i_Layer, @i_Pallet, 0, 0, 1, '', '', 0, 0, '', '', SYSDATETIME(), SYSDATETIME(), NEWID(), NULL, 0);

				while(@i_Pallet <= 1)
				begin
					INSERT [dbo].[WM_Pallet]([Id], [LocationCode], [PalletName], [MatchPalletCode], [MatchPalletName], [UniqueId], [ProductCount], [StorageQuantity]
						, [InFrozenQuantity], [OutFrozenQuantity], [StorageSequence], [ProductPosition], [BrandCodes], [BrandNames], [PalletTypeCode], [PalletTypeName]
						, [PalletNo], [InboundPositionNo], [OutboundPositionNo], [Reserve], [CreateTime], [UpdateTime], [RowVersion])
					VALUES (newid(), @v_LocationCode, '盘位'+Right('0'+cast(@i_Pallet as nvarchar),2), '', '', NULL, 0, '0', '0', '0', 0, NULL, '', '', '', '', 0, 0, 0, NULL
						, SYSDATETIME(), SYSDATETIME(), NEWID());
					set @i_Pallet = @i_Pallet+1;
				end;
				set @i_Place = @i_Place + 1;
			end
			set @i_Layer = @i_Layer + 1;
		end
		set @i_Jia = @i_Jia + 1;
	end;
	/*--范例
	INSERT [dbo].[WM_Location]([LocationCode], [LocationName], [LocationType], [WarehouseCode], [RegionCode], [ShelfCode], [PresetProductCode]
		, [PresetProductName], [InPositionNo], [OutPositionNo], [InWorkEquipmentCodes], [OutWorkEquipmentCodes], [PalletMaxReserves]
		, [MaxPalletQuantity], [OutStrategy], [OutAllotStrategy], [DisplayOrder], [AllotInOrder], [LocationRfid], [LocationLayer]
		, [LocationColumn], [CoordinateX], [CoordinateY], [LocationStatus], [FrontEquipmentCodes], [RearEquipmentCodes], [FrontPosition]
		, [RearPosition], [LockTag], [Remark], [CreateTime], [UpdateTime], [RowVersion], [EquipmentUsed], [PositionUsed])
	VALUES ('01-65-33', '01柜-65层-33位', 0, 'MDJ-BJK', 'ACS', 'ACS001R01-01', '', '', 0, 0, null, null, 5000, 1, 0, 0
		, 2164, 2080, '', 32, 65, 0, 0, 1, '', '', 0, 0, '', '', SYSDATETIME(), SYSDATETIME(), NEWID(), NULL, 0);

	INSERT [dbo].[WM_Pallet]([Id], [LocationCode], [PalletName], [MatchPalletCode], [MatchPalletName], [UniqueId], [ProductCount], [StorageQuantity]
		, [InFrozenQuantity], [OutFrozenQuantity], [StorageSequence], [ProductPosition], [BrandCodes], [BrandNames], [PalletTypeCode], [PalletTypeName]
		, [PalletNo], [InboundPositionNo], [OutboundPositionNo], [Reserve], [CreateTime], [UpdateTime], [RowVersion])
	VALUES (newid(), '01-65-33', '盘位', '', '', NULL, 0, '0', '0', '0', 0, NULL, '', '', '', '', 0, 0, 0, NULL, SYSDATETIME(), SYSDATETIME(), NEWID());
	--*/

END;
GO

EXECUTE pro_001;	----成功
GO