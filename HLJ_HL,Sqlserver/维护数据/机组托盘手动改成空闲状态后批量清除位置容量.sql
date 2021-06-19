use [FusionFLK]
update TM_WorkPosition set UsedQuantity=0 where WorkPositionNo IN (SELECT WorkPositionNo FROM WM_MachinePallet WHERE MachinePalletStatus=0) and UsedQuantity >=1;

SELECT * from TM_WorkPosition where WorkPositionNo IN (SELECT WorkPositionNo FROM WM_MachinePallet WHERE MachinePalletStatus=0) and UsedQuantity >=1;