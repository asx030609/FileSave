
USE [FusionBJK]
GO
if exists(select * from dbo.sysobjects where id=object_id(N'pro_001') and OBJECTPROPERTY(id, N'IsProcedure')=1)	--或者使用select * from dbo.sysobjects where xtype='P';？
	drop procedure pro_001;
go

create PROC pro_001
AS
BEGIN
	Declare @v_BeginJia nvarchar(20);
	Declare @v_BeginLayer nvarchar(20);
	Declare @v_Place nvarchar(20);
	Declare @i_BeginJia int = 16;
	Declare @i_BeginLayer int = 1;
	Declare @i_Place int = 1;
	set @i_BeginJia=1;
	while(@i_BeginJia <= 18)
	begin
		set @v_BeginJia = Right('0'+ cast(@i_BeginJia as nvarchar),2);
		set @i_BeginLayer=1;
		while(@i_BeginLayer <= 5)
		begin
			set @v_BeginLayer = Right('0'+cast(@i_BeginLayer as nvarchar), 2);
			set @i_Place = 1;
			while(@i_Place <= 7)
			begin
				set @v_Place = Right('0'+cast(@i_Place as nvarchar), 2);
				--print(@v_BeginJia+'-'+@v_BeginLayer+'-'+@v_Place);
				Declare @v_LocationCode nvarchar(50) = @v_BeginJia+'-'+@v_BeginLayer+'-'+@v_Place;
				Declare @v_LocationName nvarchar(80) = @v_BeginJia+'架'+@v_BeginLayer+'层'+@v_Place+'位';
				Declare @i_Pallet int = 1;
				DELETE FROM WM_Pallet WHERE LocationCode=@v_LocationCode;
				DELETE FROM WM_Location WHERE LocationCode=@v_LocationCode;
				INSERT [dbo].[WM_Location]([LocationCode], [LocationName], [LocationType], [WarehouseCode], [RegionCode], [ShelfCode], [PresetProductCode], [PresetProductName]
					, [InPositionNo], [OutPositionNo], [InWorkEquipmentCodes], [OutWorkEquipmentCodes], [PalletMaxReserves], [MaxPalletQuantity], [OutStrategy], [OutAllotStrategy]
					, [DisplayOrder], [AllotInOrder], [LocationRfid], [LocationLayer], [LocationColumn], [CoordinateX], [CoordinateY], [LocationStatus], [FrontEquipmentCodes]
					, [RearEquipmentCodes], [FrontPosition], [RearPosition], [LockTag], [Remark], [CreateTime], [UpdateTime], [RowVersion], [EquipmentUsed], [PositionUsed])
				VALUES (@v_LocationCode, @v_LocationCode, 2, 'MDJ-BJK', 'LS', 'LS-'+@v_BeginJia, '', '', 0, 0, '', '', 300, 30, 0, 0, 1, 0, '', 1, 1, 0, 0, 1, '', '', 0, 0, '', '', SYSDATETIME()
					, SYSDATETIME(), NEWID(), NULL, 0);

				while(@i_Pallet <= 30)
				begin
					INSERT [dbo].[WM_Pallet]([Id], [LocationCode], [PalletName], [MatchPalletCode], [MatchPalletName], [UniqueId], [ProductCount], [StorageQuantity], [InFrozenQuantity]
						, [OutFrozenQuantity], [StorageSequence], [ProductPosition], [BrandCodes], [BrandNames], [PalletTypeCode], [PalletTypeName], [PalletNo], [InboundPositionNo]
						, [OutboundPositionNo], [Reserve], [CreateTime], [UpdateTime], [RowVersion])
					VALUES (newid(), @v_LocationCode, '盘位'+Right('0'+cast(@i_Pallet as nvarchar),2), '', '', NULL, 0, '0', '0', '0', 0, NULL, '', '', '', '', 0, 0, 0, NULL
						, SYSDATETIME(), SYSDATETIME(), NEWID());
					set @i_Pallet = @i_Pallet+1;
				end;
				set @i_Place = @i_Place + 1;
			end
			set @i_BeginLayer = @i_BeginLayer + 1;
		end
		set @i_BeginJia = @i_BeginJia + 1;
	end;
	/*--范例
	INSERT [dbo].[WM_Location]([LocationCode], [LocationName], [LocationType], [WarehouseCode], [RegionCode], [ShelfCode], [PresetProductCode], [PresetProductName]
		, [InPositionNo], [OutPositionNo], [InWorkEquipmentCodes], [OutWorkEquipmentCodes], [PalletMaxReserves], [MaxPalletQuantity], [OutStrategy], [OutAllotStrategy]
		, [DisplayOrder], [AllotInOrder], [LocationRfid], [LocationLayer], [LocationColumn], [CoordinateX], [CoordinateY], [LocationStatus], [FrontEquipmentCodes]
		, [RearEquipmentCodes], [FrontPosition], [RearPosition], [LockTag], [Remark], [CreateTime], [UpdateTime], [RowVersion], [EquipmentUsed], [PositionUsed])
    VALUES ('16-01-01', '16架01层01位', 2, 'MDJ-BJK', 'LS', 'LS-16', '', '', 0, 0, '', '', 300, 30, 0, 0, 1, 0, '', 1, 1, 0, 0, 1, '', '', 0, 0, '', '', SYSDATETIME()
		, SYSDATETIME(), NEWID(), NULL, 0);

    INSERT [dbo].[WM_Pallet]([Id], [LocationCode], [PalletName], [MatchPalletCode], [MatchPalletName], [UniqueId], [ProductCount], [StorageQuantity], [InFrozenQuantity]
	, [OutFrozenQuantity], [StorageSequence], [ProductPosition], [BrandCodes], [BrandNames], [PalletTypeCode], [PalletTypeName], [PalletNo], [InboundPositionNo]
	, [OutboundPositionNo], [Reserve], [CreateTime], [UpdateTime], [RowVersion])
        VALUES ('0644e74a-cfa9-4057-8d99-9fd1bba40f17', '16-01-01', '盘位', '', '', NULL, 0, '0', '0', '0', 0, NULL, '', '', '', '', 0, 0, 0, NULL
		, SYSDATETIME(), SYSDATETIME(), NEWID());
	--*/

END;
GO

EXECUTE pro_001;	----成功
GO