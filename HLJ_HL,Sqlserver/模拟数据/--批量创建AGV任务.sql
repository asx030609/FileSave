USE [FusionFLK]


GO
if exists(select * from dbo.sysobjects where id=object_id(N'pro_001') and OBJECTPROPERTY(id, N'IsProcedure')=1)	--或者使用select * from dbo.sysobjects where xtype='P';？
	drop procedure pro_001;
go
/*----插入AGV任务
				INSERT [dbo].[TM_Task]([Id], [TaskNo], [TaskType], [TaskLevel], [OriginLocationCode], [TargetLocationCode], [OriginPalletId], [TargetPalletId], [OriginWorkPositionNo], [TargetWorkPositionNo], [CurrentWorkPositionNo], [WorkPathCode], [CurrentWorkPositionStatus], [TaskStatus], [StorageSequence], [CanOperationEquipment], [AppointedOperationEquipment], [Barcodes], [RFID], [SupplySerialNumber], [GetFinished], [ProSamplingBoxNos], [ProductCodes], [ProductNames], [Remark], [CreateTime], [UpdateTime], [RowVersion])
				VALUES ('1decf130-f436-4bc0-b1d4-658e743cb55c', 95, 3, 0, '01-01-01', '101001', NULL, NULL, 10101, 101001, 2230, 'SRM001-AGV', 1, 0, 0
				, ',AGV,', '', '', '', 0, 'False', NULL, NULL, NULL, '', CONVERT(datetime, '2021/4/13 15:27:14', 101), CONVERT(datetime, '2021/4/13 15:27:14', 101), NEWID());
--*/
go


create PROC pro_001
		AS
		BEGIN
			DECLARE @iTaskNo INT;
			DECLARE @iJizuNo INT;
			DECLARE @vJizuNo varchar(50);
			DECLARE @iTuopanNo INT;
			DECLARE @vTuopanNo varchar(50);
			declare @vPostionCode varchar(100);

			SET @iTaskNo = 115;
			----AGV到达卷接包机组位置
			SET @iJizuNo=1;
			WHILE @iJizuNo <= 1
			BEGIN
				set @vJizuNo = RIGHT('00'+cast(@iJizuNo as varchar), 2);
				SET @iTuopanNo = 1;
				WHILE @iTuopanNo <= 6
				BEGIN
					IF @iTuopanNo = 3 
					BEGIN
						SET @iTuopanNo = @iTuopanNo + 1;
						continue;
					END
					SET @vTuopanNo = RIGHT('000'+cast(@iTuopanNo as varchar), 3);
					set @vPostionCode = '1' + @vJizuNo + @vTuopanNo;
					PRINT (@vPostionCode);
					INSERT [dbo].[TM_Task]([Id], [TaskNo], [TaskType], [TaskLevel], [OriginLocationCode], [TargetLocationCode], [OriginPalletId], [TargetPalletId], [OriginWorkPositionNo], [TargetWorkPositionNo], [CurrentWorkPositionNo], [WorkPathCode], [CurrentWorkPositionStatus], [TaskStatus], [StorageSequence], [CanOperationEquipment], [AppointedOperationEquipment], [Barcodes], [RFID], [SupplySerialNumber], [GetFinished], [ProSamplingBoxNos], [ProductCodes], [ProductNames], [Remark], [CreateTime], [UpdateTime], [RowVersion])
						VALUES (NEWID(), @iTaskNo, 3, 0, '01-01-01', @vPostionCode, NULL, NULL, 10101, @vPostionCode, 2230, 'SRM001-AGV', 1, 0, 0
						, ',AGV,', '', '', '', 0, 'False', NULL, NULL, NULL, '', CONVERT(datetime, '2021/4/13 15:27:14', 101), CONVERT(datetime, '2021/4/13 15:27:14', 101), NEWID());
					SET @iTuopanNo = @iTuopanNo + 1;
					set @iTaskNo = @iTaskNo + 1;
				END;
				----累加1
				set @iJizuNo = @iJizuNo + 1;
			END
			--*/
		END;
GO

EXECUTE pro_001  ;
GO