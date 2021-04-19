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

			SET @iTaskNo = 0; ---
			SELECT @iTaskNo=MAX(TASKNo) FROM TM_TASK;
			SET @iTaskNo = @iTaskNo + 1;
			print(@iTaskNo);
			--/*
			set @vPostionCode = '306001';
			PRINT (@vPostionCode);
			INSERT [dbo].[TM_Task]([Id], [TaskNo], [TaskType], [TaskLevel], [OriginLocationCode], [TargetLocationCode], [OriginPalletId], [TargetPalletId], [OriginWorkPositionNo], [TargetWorkPositionNo], [CurrentWorkPositionNo], [WorkPathCode], [CurrentWorkPositionStatus], [TaskStatus], [StorageSequence], [CanOperationEquipment], [AppointedOperationEquipment], [Barcodes], [RFID], [SupplySerialNumber], [GetFinished], [ProSamplingBoxNos], [ProductCodes], [ProductNames], [Remark], [CreateTime], [UpdateTime], [RowVersion])
				VALUES (NEWID(), @iTaskNo, 3, 0, '01-01-01', @vPostionCode, NULL, NULL, 10101, @vPostionCode, 2230, 'SRM001-AGV', 1, 0, 0
				, ',AGV,', '', '', '', 0, 'False', NULL, NULL, NULL, '', CONVERT(datetime, '2021/4/13 15:27:14', 101), CONVERT(datetime, '2021/4/13 15:27:14', 101), NEWID());
			set @iTaskNo = @iTaskNo+1;
			INSERT [dbo].[TM_Task]([Id], [TaskNo], [TaskType], [TaskLevel], [OriginLocationCode], [TargetLocationCode], [OriginPalletId], [TargetPalletId], [OriginWorkPositionNo], [TargetWorkPositionNo], [CurrentWorkPositionNo], [WorkPathCode], [CurrentWorkPositionStatus], [TaskStatus], [StorageSequence], [CanOperationEquipment], [AppointedOperationEquipment], [Barcodes], [RFID], [SupplySerialNumber], [GetFinished], [ProSamplingBoxNos], [ProductCodes], [ProductNames], [Remark], [CreateTime], [UpdateTime], [RowVersion])
				VALUES (NEWID(), @iTaskNo, 3, 0, @vPostionCode, '01-01-01', NULL, NULL, @vPostionCode, 10101, @vPostionCode, 'AGV-SRM001', 1, 0, 0, ',AGV,', '', '', '', 0, 'False', NULL, NULL, NULL, '', CONVERT(datetime, '2021/4/14 14:01:44', 101), CONVERT(datetime, '2021/4/14 14:01:44', 101), NEWID());
			set @iTaskNo = @iTaskNo+1;

			set @vPostionCode = '202001';
			PRINT (@vPostionCode);
			INSERT [dbo].[TM_Task]([Id], [TaskNo], [TaskType], [TaskLevel], [OriginLocationCode], [TargetLocationCode], [OriginPalletId], [TargetPalletId], [OriginWorkPositionNo], [TargetWorkPositionNo], [CurrentWorkPositionNo], [WorkPathCode], [CurrentWorkPositionStatus], [TaskStatus], [StorageSequence], [CanOperationEquipment], [AppointedOperationEquipment], [Barcodes], [RFID], [SupplySerialNumber], [GetFinished], [ProSamplingBoxNos], [ProductCodes], [ProductNames], [Remark], [CreateTime], [UpdateTime], [RowVersion])
				VALUES (NEWID(), @iTaskNo, 3, 0, '01-01-02', @vPostionCode, NULL, NULL, 10102, @vPostionCode, 2230, 'SRM001-AGV', 1, 0, 0
				, ',AGV,', '', '', '', 0, 'False', NULL, NULL, NULL, '', CONVERT(datetime, '2021/4/13 15:27:14', 101), CONVERT(datetime, '2021/4/13 15:27:14', 101), NEWID());
			set @iTaskNo = @iTaskNo+1;
			INSERT [dbo].[TM_Task]([Id], [TaskNo], [TaskType], [TaskLevel], [OriginLocationCode], [TargetLocationCode], [OriginPalletId], [TargetPalletId], [OriginWorkPositionNo], [TargetWorkPositionNo], [CurrentWorkPositionNo], [WorkPathCode], [CurrentWorkPositionStatus], [TaskStatus], [StorageSequence], [CanOperationEquipment], [AppointedOperationEquipment], [Barcodes], [RFID], [SupplySerialNumber], [GetFinished], [ProSamplingBoxNos], [ProductCodes], [ProductNames], [Remark], [CreateTime], [UpdateTime], [RowVersion])
				VALUES (NEWID(), @iTaskNo, 3, 0, @vPostionCode, '01-01-02', NULL, NULL, @vPostionCode, 10102, @vPostionCode, 'AGV-SRM001', 1, 0, 0, ',AGV,', '', '', '', 0, 'False', NULL, NULL, NULL, '', CONVERT(datetime, '2021/4/14 14:01:44', 101), CONVERT(datetime, '2021/4/14 14:01:44', 101), NEWID());
			set @iTaskNo = @iTaskNo+1;

			set @vPostionCode = '203001';
			PRINT (@vPostionCode);
			INSERT [dbo].[TM_Task]([Id], [TaskNo], [TaskType], [TaskLevel], [OriginLocationCode], [TargetLocationCode], [OriginPalletId], [TargetPalletId], [OriginWorkPositionNo], [TargetWorkPositionNo], [CurrentWorkPositionNo], [WorkPathCode], [CurrentWorkPositionStatus], [TaskStatus], [StorageSequence], [CanOperationEquipment], [AppointedOperationEquipment], [Barcodes], [RFID], [SupplySerialNumber], [GetFinished], [ProSamplingBoxNos], [ProductCodes], [ProductNames], [Remark], [CreateTime], [UpdateTime], [RowVersion])
				VALUES (NEWID(), @iTaskNo, 3, 0, '01-01-03', @vPostionCode, NULL, NULL, 10103, @vPostionCode, 2230, 'SRM001-AGV', 1, 0, 0
				, ',AGV,', '', '', '', 0, 'False', NULL, NULL, NULL, '', CONVERT(datetime, '2021/4/13 15:27:14', 101), CONVERT(datetime, '2021/4/13 15:27:14', 101), NEWID());
			set @iTaskNo = @iTaskNo+1;
			INSERT [dbo].[TM_Task]([Id], [TaskNo], [TaskType], [TaskLevel], [OriginLocationCode], [TargetLocationCode], [OriginPalletId], [TargetPalletId], [OriginWorkPositionNo], [TargetWorkPositionNo], [CurrentWorkPositionNo], [WorkPathCode], [CurrentWorkPositionStatus], [TaskStatus], [StorageSequence], [CanOperationEquipment], [AppointedOperationEquipment], [Barcodes], [RFID], [SupplySerialNumber], [GetFinished], [ProSamplingBoxNos], [ProductCodes], [ProductNames], [Remark], [CreateTime], [UpdateTime], [RowVersion])
				VALUES (NEWID(), @iTaskNo, 3, 0, @vPostionCode, '01-01-03', NULL, NULL, @vPostionCode, 10103, @vPostionCode, 'AGV-SRM001', 1, 0, 0, ',AGV,', '', '', '', 0, 'False', NULL, NULL, NULL, '', CONVERT(datetime, '2021/4/14 14:01:44', 101), CONVERT(datetime, '2021/4/14 14:01:44', 101), NEWID());
			set @iTaskNo = @iTaskNo+1;


			--*/
		END;
GO

EXECUTE pro_001  ;
GO