USE [FusionFLK]
--DELETE FROM WM_MachinePallet;
/*----这里是头部只给出示例sql，另外很多条sql都放在另一分离出的主表文档中
DELETE FROM WM_Machine;
INSERT [dbo].[WM_Machine]([MachineCode], [MachineName], [MachineType], [MachineClassify], [ClientIP], [Active], [Using], [ExternalMachineCode], [CreateTime], [UpdateTime], [RowVersion]) VALUES ('J101', '1#卷烟机', 2, NULL, '199.199.160.1:80', 'True', 'False', '', CONVERT(datetime, '2021/3/31 14:47:26', 101), CONVERT(datetime, '2021/3/31 14:47:26', 101), NEWID());
INSERT [dbo].[WM_Machine]([MachineCode], [MachineName], [MachineType], [MachineClassify], [ClientIP], [Active], [Using], [ExternalMachineCode], [CreateTime], [UpdateTime], [RowVersion]) VALUES ('B201', '1#包装机', 3, NULL, '199.199.160.15:80', 'True', 'False', '', CONVERT(datetime, '2021/3/31 14:47:26', 101), CONVERT(datetime, '2021/3/31 14:47:26', 101), NEWID());
INSERT [dbo].[WM_Machine]([MachineCode], [MachineName], [MachineType], [MachineClassify], [ClientIP], [Active], [Using], [ExternalMachineCode], [CreateTime], [UpdateTime], [RowVersion]) VALUES ('Z301', '1#封装箱', 1, NULL, '199.199.160.34:80', 'True', 'False', '', CONVERT(datetime, '2021/3/31 14:47:26', 101), CONVERT(datetime, '2021/3/31 14:47:26', 101), NEWID());

----机组下的托盘列表
    INSERT [dbo].[WM_MachinePallet]([PalletPosition], [MachineCode], [MachinePalletName], [PalletTypeCode], [PalletTypeName], [WorkPositionNo], [WorkPositionName], [CurrentBrandCode], [CurrentBrandName], [CurrentMatchPalletCode], [CurrentMatchPalletName], [CurrentUniqueId], [StorageTime], [Active], [SyncMachinePalletStatus], [CacheRegion], [MachinePalletStatus], [CreateTime], [UpdateTime], [RowVersion])
    VALUES (1, 'J101', '101001', 'testPalletType01', '测试托盘类型01', 101001, '8011', '', '', '', '', '', NULL, 'True', 'True', 'False', 0, CONVERT(datetime, '2021/3/31 14:54:03', 101), CONVERT(datetime, '2021/3/31 14:54:03', 101), NEWID());

--*/

----规律是，共有1-13号机台，可以通过机台号找作业位置，比如1=>机组作业位置为：{101 || 001-005},由作业位置，通过Tm_position表得到作业名称，比如示例的8011
GO
if exists(select * from dbo.sysobjects where id=object_id(N'pro_001') and OBJECTPROPERTY(id, N'IsProcedure')=1)
	drop procedure pro_001;
go
create procedure pro_001
	AS
	begin
		DECLARE @iJizuNo INT;
		SET @iJizuNo=1;
		WHile @iJizuNo <= 3
		begin
			declare @vJizuNo nvarchar(100);

			declare @iTuoPanNo INT;
			declare @vWorkPositionNo varchar(100);
			declare @vWorkPositionName varchar(100);
			----封装箱
			set @iTuoPanNo = 1;
			while @iTuoPanNo <=2
			begin
				set @vJizuNo ='F2'+RIGHT('00' + CAST(@iJizuNo as varchar), 2);
				print(@vJizuNo);
				set @vWorkPositionNo ='';
				set @vWorkPositionNo='2'+RIGHT('00' + CAST(@iJizuNo as varchar), 2)+ RIGHT('000'+CAST(@iTuoPanNo as varchar),3);
				SELECT @vWorkPositionName=WorkPositionName FROM TM_WorkPosition where WorkPositionNo=@vWorkPositionNo;
				INSERT [dbo].[WM_MachinePallet]([PalletPosition], [MachineCode], [MachinePalletName], [PalletTypeCode], [PalletTypeName], [WorkPositionNo], [WorkPositionName], [CurrentBrandCode], [CurrentBrandName], [CurrentMatchPalletCode], [CurrentMatchPalletName], [CurrentUniqueId], [StorageTime], [Active], [SyncMachinePalletStatus], [CacheRegion], [MachinePalletStatus], [CreateTime], [UpdateTime], [RowVersion])
					VALUES (@iTuoPanNo, @vJizuNo, @vWorkPositionNo, 'testPalletType01', '测试托盘类型01', @vWorkPositionNo, @vWorkPositionName, '', '', '', '', '', NULL, 'True', 'True', 'False', 0, CONVERT(datetime, '2021/3/31 14:54:03', 101), CONVERT(datetime, '2021/3/31 14:54:03', 101), NEWID());
				print('    '+@vWorkPositionNo + '    '+@vWorkPositionName);
				set @iTuoPanNo = @iTuopanNo + 1;
			end;

			set @iJizuNo=@iJizuNo+1;
		end;
	end;
go
exec pro_001;
GO