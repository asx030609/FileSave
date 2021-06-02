use [FusionFLK]

UPDATE WM_ProductionPlan SET ProductionPlanStatus=3;	--已结单
UPDATE WM_MachineHandover SET TransferBillStatus=2;	--已接收
update WM_MachinePallet set MachinePalletStatus=2 WHERE MachinePalletStatus=6;	--移交状态改成有料状态

declare @PdPlanNo varchar(50);
declare @MachineCode varchar(50);
declare @BrandCode varchar(50);
declare @MachineName varchar(50);
declare @BrandName varchar(50);

set @PdPlanNo=cast(getdate() as varchar);
INSERT [dbo].[WM_ProductionPlan]([ProductionPlanNo], [OriginPlanNo], [PlanBeginTime], [PlanEndTime], [PlanDate], [Maker], [MakeTime], [Auditor], [InBillNo], [OutBillNo], [AuditTime], [ProductionPlanStatus], [ProductionPlanOrigin], [CreateTime], [UpdateTime], [RowVersion])
VALUES (@PdPlanNo, '', GETDATE(), DATEADD(day,1,GETDATE()), GETDATE(), 'administrator', GETDATE(), '', NULL, NULL, getdate(), 2, 0, GETDATE(), GETDATE(), NEWID());

set @BrandCode='6901028105606';
SELECT @BrandName=BrandName FROM BI_Brand WHERE BrandCode=@BrandCode;
set @MachineCode='';

DECLARE My_Cursor CURSOR --定义游标
FOR (SELECT MachineCode FROM WM_Machine)-- where MachineCode in ('B101')) --查出需要的集合放到游标中
OPEN My_Cursor; --打开游标
FETCH NEXT FROM My_Cursor INTO @MachineCode;
WHILE @@FETCH_STATUS = 0
    BEGIN
		set @MachineName='';
		SELECT @MachineName=MachineName FROM WM_Machine WHERE MachineCode=@MachineCode;
		print(@MachineName+@MachineCode);
		INSERT [dbo].[WM_ProductionPlanDetail]([Id], [ProductionPlanNo], [SerialNumber], [TeamCode], [TeamName], [ShiftCode], [ShiftName], [MachineCode], [MachineName], [BrandCode], [BrandName], [OriginWorkNo], [ProductionPlanDetailStatus], [ProductionBeginTime], [ProductionEndTime], [CreateTime], [UpdateTime], [RowVersion])
			VALUES (newid(), @PdPlanNo, 1, '1', '甲班', NULL, NULL, @MachineCode, @MachineName, @BrandCode, @BrandName, '', 0, NULL, NULL, GETDATE(), GETDATE(), NEWID());
	
        FETCH NEXT FROM My_Cursor INTO @MachineCode;
    END
CLOSE My_Cursor; --关闭游标
DEALLOCATE My_Cursor; --释放游标
