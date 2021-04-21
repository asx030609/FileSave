use [FusionFLK]

DELETE FROM [WM_ProductionPlanDetail];
DELETE FROM [WM_ProductionPlan];

declare @PdPlanNo varchar(50);
declare @MachineCode varchar(50);
declare @BrandCode varchar(50);
declare @MachineName varchar(50);
declare @BrandName varchar(50);

set @PdPlanNo='P202104170001';
INSERT [dbo].[WM_ProductionPlan]([ProductionPlanNo], [OriginPlanNo], [PlanBeginTime], [PlanEndTime], [PlanDate], [Maker], [MakeTime], [Auditor], [InBillNo], [OutBillNo], [AuditTime], [ProductionPlanStatus], [ProductionPlanOrigin], [CreateTime], [UpdateTime], [RowVersion])
VALUES (@PdPlanNo, '', CONVERT(datetime, '2021/4/17 0:00:00', 101), CONVERT(datetime, '2021/4/17 23:59:59', 101), CONVERT(datetime, '2021/4/17 0:00:00', 101), 'administrator', CONVERT(datetime, '2021/4/17 9:05:05', 101), '', NULL, NULL, NULL, 0, 0, CONVERT(datetime, '2021/4/17 9:05:05', 101), CONVERT(datetime, '2021/4/17 9:05:05', 101), NEWID());

set @BrandCode='testBrandCode01';
SELECT @BrandName=BrandName FROM BI_Brand WHERE BrandCode=@BrandCode;
set @MachineCode='Z301';

DECLARE My_Cursor CURSOR --定义游标
FOR (SELECT MachineCode FROM WM_Machine) --查出需要的集合放到游标中
OPEN My_Cursor; --打开游标
FETCH NEXT FROM My_Cursor INTO @MachineCode;
WHILE @@FETCH_STATUS = 0
    BEGIN
		set @MachineName='';
		SELECT @MachineName=MachineName FROM WM_Machine WHERE MachineCode=@MachineCode;
		print(@MachineName+@MachineCode);
		INSERT [dbo].[WM_ProductionPlanDetail]([Id], [ProductionPlanNo], [SerialNumber], [TeamCode], [TeamName], [ShiftCode], [ShiftName], [MachineCode], [MachineName], [BrandCode], [BrandName], [OriginWorkNo], [ProductionPlanDetailStatus], [ProductionBeginTime], [ProductionEndTime], [CreateTime], [UpdateTime], [RowVersion])
			VALUES (newid(), @PdPlanNo, 1, '1', '甲班', NULL, NULL, @MachineCode, @MachineName, @BrandCode, @BrandName, '', 0, NULL, NULL, CONVERT(datetime, '2021/4/17 9:05:18', 101), CONVERT(datetime, '2021/4/17 9:05:18', 101), NEWID());
	
        FETCH NEXT FROM My_Cursor INTO @MachineCode;
    END
CLOSE My_Cursor; --关闭游标
DEALLOCATE My_Cursor; --释放游标
