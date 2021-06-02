use [FusionFLK]

--*/

----更新前2天之前的所有生产计划状态为已结单
UPDATE WM_ProductionPlan SET ProductionPlanStatus=3 WHERE CreateTime <= TRUNC( SYSDATE, 'DD' ) -2;
----测试的时候该直接清空信息
--DELETE FROM WM_PRODUCTION_PLANU;
--删除机组下盘位细表
DELETE FROM WM_MachinePalletDetail;
----更新所有机组中的盘位为空闲
update WM_MachinePallet set CurrentBrandCode =  '' , CurrentBrandName =  '' 
    , CurrentMatchPalletCode =  '' , CurrentMatchPalletName =  '' , CurrentUniqueId =  '' , MachinePalletStatus =  '0' 
    , UpdateTime = GETDATE() , RowVersion=newid();
update TM_WorkPosition SET UsedQuantity=0 WHERE len( WorkPositionNo)=6;
----清空库存pallet信息，对应点：长度为6
UPDATE WM_Pallet SET MatchPalletCode='', MatchPalletName='',UniqueId='',ProductCount=0,StorageQuantity=0,InFrozenQuantity=0,OutFrozenQuantity=0
    ,ProductPosition='',BrandCodes='',BrandNames='',PalletTypeCode='',PalletTypeName='' WHERE len(LocationCode)=6;

delete FROM WM_Storage WHERE LEN(LocationCode)=6;
