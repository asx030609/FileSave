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
			SET @workPathCode='AGV-CR01-01';
			------删除原先这个路径编码的信息
			DELETE FROM TM_WorkPathNode WHERE WorkPathCode=@workPathCode;
			DELETE FROM TM_WorkPath WHERE WorkPathCode=@workPathCode;
            INSERT [dbo].[TM_WorkPath]([WorkPathCode], [WorkPathName], [OriginWorkRegionCode], [TargetWorkRegionCode], [Active], [Priority], [Remark], [CreateTime], [UpdateTime], [RowVersion])
            	VALUES (@workPathCode, @workPathCode, 'r-srm01', 'r-srm01', 'True', 0, '', CONVERT(datetime, '2021/3/17 9:35:07', 101), CONVERT(datetime, '2021/3/17 9:35:07', 101), NEWID());

					
			DECLARE @iColum INT;
    		DECLARE @iLayer INT;
			
			SET @iColum = 1;
			SET @orderNum = 1;
			WHILE @iColum <= 32 
			BEGIN    
    			SET @iLayer=1;
    			DECLARE @vLayer varchar(50);
				DECLARE @vColum varchar(50);
				SET @vColum = RIGHT('00'+cast(@iColum as varchar), 2);

				WHILE @iLayer <= 11
				BEGIN
					set @vLayer = RIGHT('00'+cast(@iLayer as varchar), 2);
					PRINT ('1' + @vColum + @vLayer);
					INSERT [dbo].[TM_WorkPathNode]([Id], [WorkPathCode], [ParentId], [WorkPositionNo], [WorkPositionName], [PathNodeOrder], [CreateTime], [UpdateTime], [RowVersion])
            			VALUES (NEWID(), @workPathCode, NULL, cast('1' + @vColum + @vLayer as int), '01排'+@vColum+'列'+@vLayer+'层', @orderNum, CONVERT(datetime, '2021/3/17 9:30:22', 101), CONVERT(datetime, '2021/3/17 9:30:22', 101), NEWID());
						
					set @iLayer = @iLayer + 1;
					SET @orderNum = @orderNum + 1;
				END;
				
				SET @iColum = @iColum + 1;
			END
			--FOR INT I IN 0 .. 13 LOOP	----有问题
			--	print i;
			--END LOOP;
		END;
GO

EXECUTE pro_001  ;
GO