/*--�˴��漰��AGV�ṩ����ҵ���룬������ѭ�����������⹹�����insert�����ܶࡣ
INSERT [dbo].[TM_WorkPosition]([WorkPositionNo], [WorkPositionName], [PositionType], [WorkRegionCode], [SingleTravelPosition], [SingleLiftPosition], [SingleForkExtension], [DoubleTravelPosition], [DoubleLiftPosition], [DoubleForkExtension], [AbleStockOut], [AbleStockInPallet], [HasGetRequest], [HasPutRequest], [ServerCode], [ServerName], [SupplyPositionCode], [CacheCapacity], [CachedQuantity], [PositionCapacity], [UsedQuantity], [Active], [Remark], [CreateTime], [UpdateTime], [RowVersion])
 VALUES (101003, '8013', 0, 'r-AGV', 0, 0, 0, 0, 0, 0, 'True', 'False', 'False', 'False', '', '', '', 1, 0, 1, 0, 'True', '', CONVERT(datetime, '2021/3/22 15:18:51', 101), CONVERT(datetime, '2021/3/22 15:18:51', 101), NEWID())
--*/
/*
INSERT [dbo].[TM_OperationEquipment]([Id], [WorkPositionNo], [WorkEquipmentCode], [WorkEquipmentName], [CreateTime], [UpdateTime], [RowVersion])
VALUES (NEWID(), 101002, 'AGV', 'AGV', CONVERT(datetime, '2021/3/22 14:49:38', 101), CONVERT(datetime, '2021/3/22 14:49:38', 101), NEWID());
--*/


USE [FusionFLK];
GO
if exists(select * from dbo.sysobjects where id=object_id(N'pro_001') and OBJECTPROPERTY(id, N'IsProcedure')=1)	--����ʹ��select * from dbo.sysobjects where xtype='P';��
	drop procedure pro_001;
go

create PROC pro_001
		AS
		BEGIN
			DECLARE @iJizuNo INT;
			DECLARE @vJizuNo varchar(50);
			DECLARE @iTuopanNo INT;
			DECLARE @vTuopanNo varchar(50);
			/*----�����װ���;�ӻ���ҵλ��
			SET @iJizuNo=1;
			WHILE @iJizuNo <= 13
			BEGIN
				set @vJizuNo = RIGHT('00'+cast(@iJizuNo as varchar), 2);
				SET @iTuopanNo = 1;
				WHILE @iTuopanNo <= 6
				BEGIN
					SET @vTuopanNo = RIGHT('000'+cast(@iTuopanNo as varchar), 3);
					PRINT ('1' + @vJizuNo + @vTuopanNo);
					----������ҵλ��
					INSERT [dbo].[TM_OperationEquipment]([Id], [WorkPositionNo], [WorkEquipmentCode], [WorkEquipmentName], [CreateTime], [UpdateTime], [RowVersion])
						VALUES (NEWID(), ('1' + @vJizuNo + @vTuopanNo), 'AGV', 'AGV', CONVERT(datetime, '2021/3/22 14:49:38', 101), CONVERT(datetime, '2021/3/22 14:49:38', 101), NEWID());
					SET @iTuopanNo = @iTuopanNo + 1;
				END;
				----�ۼ�1
				set @iJizuNo = @iJizuNo + 1;
			END
			--*/
			----�����װ����ҵλ��
			SET @iJizuNo=1;
			WHILE @iJizuNo <= 3
			BEGIN
				set @vJizuNo = RIGHT('00'+cast(@iJizuNo as varchar), 2);
				SET @iTuopanNo = 1;
				WHILE @iTuopanNo <= 2
				BEGIN
					SET @vTuopanNo = RIGHT('000'+cast(@iTuopanNo as varchar), 3);
					PRINT ('2' + @vJizuNo + @vTuopanNo);
					----������ҵλ��
					INSERT [dbo].[TM_OperationEquipment]([Id], [WorkPositionNo], [WorkEquipmentCode], [WorkEquipmentName], [CreateTime], [UpdateTime], [RowVersion])
						VALUES (NEWID(), ('2' + @vJizuNo + @vTuopanNo), 'AGV', 'AGV', CONVERT(datetime, '2021/3/22 14:49:38', 101), CONVERT(datetime, '2021/3/22 14:49:38', 101), NEWID());
					SET @iTuopanNo = @iTuopanNo + 1;
				END;
				----�ۼ�1
				set @iJizuNo = @iJizuNo + 1;
			END
			--*/
			----�����˰�����ҵλ��
			SET @iJizuNo=1;
			WHILE @iJizuNo <= 6
			BEGIN
				set @vJizuNo = RIGHT('00'+cast(@iJizuNo as varchar), 2);
				SET @iTuopanNo = 1;
				WHILE @iTuopanNo <= 1
				BEGIN
					SET @vTuopanNo = RIGHT('000'+cast(@iTuopanNo as varchar), 3);
					PRINT ('3' + @vJizuNo + @vTuopanNo);
					----������ҵλ��
					INSERT [dbo].[TM_OperationEquipment]([Id], [WorkPositionNo], [WorkEquipmentCode], [WorkEquipmentName], [CreateTime], [UpdateTime], [RowVersion])
						VALUES (NEWID(), ('3' + @vJizuNo + @vTuopanNo), 'AGV', 'AGV', CONVERT(datetime, '2021/3/22 14:49:38', 101), CONVERT(datetime, '2021/3/22 14:49:38', 101), NEWID());
					SET @iTuopanNo = @iTuopanNo + 1;
				END;
				----�ۼ�1
				set @iJizuNo = @iJizuNo + 1;
			END
			--*/
		END;
GO

EXECUTE pro_001  ;
GO