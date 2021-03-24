USE [FusionFLK];
GO
if exists(select * from dbo.sysobjects where id=object_id(N'pro_001') and OBJECTPROPERTY(id, N'IsProcedure')=1)	--或者使用select * from dbo.sysobjects where xtype='P';？
	drop procedure pro_001;
go

create PROC pro_001
		AS
		DECLARE @workPathCode VARCHAR(MAX);
		declare @orderNum INT;
		BEGIN
			SET @workPathCode='CR02-CR02';
			------删除原先这个路径编码的信息
			DELETE FROM TM_WorkPathNode WHERE WorkPathCode=@workPathCode;
			DELETE FROM TM_WorkPath WHERE WorkPathCode=@workPathCode;
            INSERT [dbo].[TM_WorkPath]([WorkPathCode], [WorkPathName], [OriginWorkRegionCode], [TargetWorkRegionCode], [Active], [Priority], [Remark], [CreateTime], [UpdateTime], [RowVersion])
            	VALUES (@workPathCode, @workPathCode, 'r-srm01', 'r-srm01', 'True', 0, '', CONVERT(datetime, '2021/3/17 9:35:07', 101), CONVERT(datetime, '2021/3/17 9:35:07', 101), NEWID());

			SET @orderNum = 1;
			DECLARE @iLayer INT;
			SET @iLayer=1;
			WHILE @iLayer <= 11
			BEGIN
				DECLARE @vLayer varchar(50);
				set @vLayer = RIGHT('00'+cast(@iLayer as varchar), 2);
				
				DECLARE @iColum INT;
				SET @iColum = 1;
				WHILE @iColum <= 32
				BEGIN
					DECLARE @vColum varchar(50);
					SET @vColum = RIGHT('00'+cast(@iColum as varchar), 2);
					PRINT ('3' + @vColum + @vLayer);
					INSERT [dbo].[TM_WorkPathNode]([Id], [WorkPathCode], [ParentId], [WorkPositionNo], [WorkPositionName], [PathNodeOrder], [CreateTime], [UpdateTime], [RowVersion])
            			VALUES (NEWID(), @workPathCode, NULL, cast('3' + @vColum + @vLayer as int), '03排'+@vColum+'列'+@vLayer+'层', @orderNum, CONVERT(datetime, '2021/3/17 9:30:22', 101), CONVERT(datetime, '2021/3/17 9:30:22', 101), NEWID());

					SET @iColum = @iColum + 1;
					SET @orderNum = @orderNum + 1;
				END;
				
				set @iLayer = @iLayer + 1;
			END
			--FOR INT I IN 0 .. 13 LOOP	----有问题
			--	print i;
			--END LOOP;
		END;
GO

EXECUTE pro_001  ;
GO