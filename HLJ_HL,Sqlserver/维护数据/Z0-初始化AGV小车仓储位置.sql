
/*
----插入货架
INSERT [dbo].[WM_Shelf]([WarehouseCode], [RegionCode], [ShelfCode], [ShelfName], [DisplayOrder], [Active], [Remark], [CreateTime], [UpdateTime], [RowVersion])
	VALUES ('w001', 'w00r02', 'w001r02-02', '2#卷接机组', 2, 'True', '', CONVERT(datetime, '2021/3/22 16:07:31', 101), CONVERT(datetime, '2021/3/22 16:07:31', 101), NEWID());

----插入货位
INSERT [dbo].[WM_Location]([LocationCode], [LocationName], [LocationType], [WarehouseCode], [RegionCode], [ShelfCode], [PresetProductCode], [PresetProductName], [InPositionNo], [OutPositionNo], [InWorkEquipmentCodes], [OutWorkEquipmentCodes], [PalletMaxReserves], [MaxPalletQuantity], [OutStrategy], [OutAllotStrategy], [DisplayOrder], [AllotInOrder], [LocationRfid], [LocationLayer], [LocationColumn], [CoordinateX], [CoordinateY], [LocationStatus], [FrontEquipmentCodes], [RearEquipmentCodes], [FrontPosition], [RearPosition], [LockTag], [Remark], [CreateTime], [UpdateTime], [RowVersion], [EquipmentUsed], [PositionUsed])
VALUES (@vLocCode, @vLocCode, 2, 'w001', 'w00r02', 'w001r02-02', '', '', cast(@vLocCode as int), cast(@vLocCode as int), ',AGV,', ',AGV,', 50, 200, 0, 0, 1, 0, '', 1, 1, 0, 0, 1, '', '', 0, 0, '', '', CONVERT(datetime, '2021/3/22 16:12:20', 101), CONVERT(datetime, '2021/3/22 16:12:20', 101), NEWID(), NULL, 0)

----托盘要循环插入200次
INSERT [dbo].[WM_Pallet]([Id], [LocationCode], [PalletName], [MatchPalletCode], [MatchPalletName], [UniqueId], [ProductCount], [StorageQuantity], [InFrozenQuantity], [OutFrozenQuantity], [StorageSequence], [ProductPosition], [BrandCodes], [BrandNames], [PalletTypeCode], [PalletTypeName], [PalletNo], [InboundPositionNo], [OutboundPositionNo], [Reserve], [CreateTime], [UpdateTime], [RowVersion])
VALUES ('ebb046ab-808d-4bf4-9b6c-183920d890d9', @vLocCode, '盘位', '', '', NULL, 0, '0', '0', '0', 0, NULL, '', '', '', '', 0, 0, 0, NULL, CONVERT(datetime, '2021/3/22 16:12:20', 101), CONVERT(datetime, '2021/3/22 16:12:20', 101), NEWID());
--*/


USE [FusionFLK];
GO
if exists(select * from dbo.sysobjects where id=object_id(N'pro_001') and OBJECTPROPERTY(id, N'IsProcedure')=1)	--或者使用select * from dbo.sysobjects where xtype='P';？
	drop procedure pro_001;
go

create PROC pro_001
		AS
		BEGIN
			DECLARE @iJizuNo INT;
			SET @iJizuNo=1;
			WHILE @iJizuNo <= 13
			BEGIN
				DECLARE @vJizuNo varchar(50);
				set @vJizuNo = RIGHT('00'+cast(@iJizuNo as varchar), 2);
				DECLARE @vShelfCode varchar(50);
				set @vShelfCode = 'w001r02-'+@vJizuNo;
				
				----插入货架
				INSERT [dbo].[WM_Shelf]([WarehouseCode], [RegionCode], [ShelfCode], [ShelfName], [DisplayOrder], [Active], [Remark], [CreateTime], [UpdateTime], [RowVersion])
					VALUES ('w001', 'w001r02', @vShelfCode, cast(@iJizuNo as varchar)+'#卷接机组', @iJizuNo, 'True', '', CONVERT(datetime, '2021/3/22 16:07:31', 101), CONVERT(datetime, '2021/3/22 16:07:31', 101), NEWID());

				DECLARE @iTuopanNo INT;
				SET @iTuopanNo = 1;
				WHILE @iTuopanNo <= 6
				BEGIN
					DECLARE @vTuopanNo varchar(50);
					SET @vTuopanNo = RIGHT('000'+cast(@iTuopanNo as varchar), 3);
					
					DECLARE @vLocCode varchar(50);
					SET @vLocCode = '1' + @vJizuNo + @vTuopanNo;
					print(@vLocCode);
					----插入货位
					INSERT [dbo].[WM_Location]([LocationCode], [LocationName], [LocationType], [WarehouseCode], [RegionCode], [ShelfCode], [PresetProductCode], [PresetProductName], [InPositionNo], [OutPositionNo], [InWorkEquipmentCodes], [OutWorkEquipmentCodes], [PalletMaxReserves], [MaxPalletQuantity], [OutStrategy], [OutAllotStrategy], [DisplayOrder], [AllotInOrder], [LocationRfid], [LocationLayer], [LocationColumn], [CoordinateX], [CoordinateY], [LocationStatus], [FrontEquipmentCodes], [RearEquipmentCodes], [FrontPosition], [RearPosition], [LockTag], [Remark], [CreateTime], [UpdateTime], [RowVersion], [EquipmentUsed], [PositionUsed])
					VALUES (@vLocCode, @vLocCode, 2, 'w001', 'w001r02', @vShelfCode, '', '', cast(@vLocCode as int), cast(@vLocCode as int), ',AGV,', ',AGV,', 50, 200, 0, 0, 1, 0, '', 1, 1, 0, 0, 1, '', '', 0, 0, '', '', CONVERT(datetime, '2021/3/22 16:12:20', 101), CONVERT(datetime, '2021/3/22 16:12:20', 101), NEWID(), NULL, 0)

					----托盘要循环插入200次
					DECLARE @iPaNum int;
					set @iPaNum = 1;
					while @iPaNum <= 200
					BEGIN
						INSERT [dbo].[WM_Pallet]([Id], [LocationCode], [PalletName], [MatchPalletCode], [MatchPalletName], [UniqueId], [ProductCount], [StorageQuantity], [InFrozenQuantity], [OutFrozenQuantity], [StorageSequence], [ProductPosition], [BrandCodes], [BrandNames], [PalletTypeCode], [PalletTypeName], [PalletNo], [InboundPositionNo], [OutboundPositionNo], [Reserve], [CreateTime], [UpdateTime], [RowVersion])
							VALUES (NEWID(), @vLocCode, '盘位'+RIGHT('000'+cast(@iPaNum as varchar), 3), '', '', NULL, 0, '0', '0', '0', 0, NULL, '', '', '', '', 0, 0, 0, NULL, CONVERT(datetime, '2021/3/22 16:12:20', 101), CONVERT(datetime, '2021/3/22 16:12:20', 101), NEWID());
						set @iPaNum = @iPaNum + 1;
					END;
					SET @iTuopanNo = @iTuopanNo + 1;
				END;
				
				set @iJizuNo = @iJizuNo + 1;
			END
		END;
GO

EXECUTE pro_001  ;
GO