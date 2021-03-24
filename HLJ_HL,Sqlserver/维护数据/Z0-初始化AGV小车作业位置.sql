/*--此次涉及到AGV提供的作业编码，不好用循环，所以另外构建多个insert语句会快很多。
INSERT [dbo].[TM_WorkPosition]([WorkPositionNo], [WorkPositionName], [PositionType], [WorkRegionCode], [SingleTravelPosition], [SingleLiftPosition], [SingleForkExtension], [DoubleTravelPosition], [DoubleLiftPosition], [DoubleForkExtension], [AbleStockOut], [AbleStockInPallet], [HasGetRequest], [HasPutRequest], [ServerCode], [ServerName], [SupplyPositionCode], [CacheCapacity], [CachedQuantity], [PositionCapacity], [UsedQuantity], [Active], [Remark], [CreateTime], [UpdateTime], [RowVersion])
 VALUES (101003, '8013', 0, 'r-AGV', 0, 0, 0, 0, 0, 0, 'True', 'False', 'False', 'False', '', '', '', 1, 0, 1, 0, 'True', '', CONVERT(datetime, '2021/3/22 15:18:51', 101), CONVERT(datetime, '2021/3/22 15:18:51', 101), NEWID())
--*/
/*
INSERT [dbo].[TM_OperationEquipment]([Id], [WorkPositionNo], [WorkEquipmentCode], [WorkEquipmentName], [CreateTime], [UpdateTime], [RowVersion])
VALUES (NEWID(), 101002, 'AGV', 'AGV', CONVERT(datetime, '2021/3/22 14:49:38', 101), CONVERT(datetime, '2021/3/22 14:49:38', 101), NEWID());
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
				
				DECLARE @iTuopanNo INT;
				SET @iTuopanNo = 1;
				WHILE @iTuopanNo <= 6
				BEGIN
					DECLARE @vTuopanNo varchar(50);
					SET @vTuopanNo = RIGHT('000'+cast(@iTuopanNo as varchar), 3);
					PRINT ('1' + @vJizuNo + @vTuopanNo);

					INSERT [dbo].[TM_OperationEquipment]([Id], [WorkPositionNo], [WorkEquipmentCode], [WorkEquipmentName], [CreateTime], [UpdateTime], [RowVersion])
						VALUES (NEWID(), ('1' + @vJizuNo + @vTuopanNo), 'AGV', 'AGV', CONVERT(datetime, '2021/3/22 14:49:38', 101), CONVERT(datetime, '2021/3/22 14:49:38', 101), NEWID());
					SET @iTuopanNo = @iTuopanNo + 1;
				END;
				
				set @iJizuNo = @iJizuNo + 1;
			END
		END;
GO

EXECUTE pro_001  ;
GO