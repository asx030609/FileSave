use [FusionFLK]

--*/

----����ǰ2��֮ǰ�����������ƻ�״̬Ϊ�ѽᵥ
UPDATE WM_ProductionPlan SET ProductionPlanStatus=3 WHERE CreateTime <= TRUNC( SYSDATE, 'DD' ) -2;
----���Ե�ʱ���ֱ�������Ϣ
--DELETE FROM WM_PRODUCTION_PLANU;
--ɾ����������λϸ��
DELETE FROM WM_MachinePalletDetail;
----�������л����е���λΪ����
update WM_MachinePallet set CurrentBrandCode =  '' , CurrentBrandName =  '' 
    , CurrentMatchPalletCode =  '' , CurrentMatchPalletName =  '' , CurrentUniqueId =  '' , MachinePalletStatus =  '0' 
    , UpdateTime = GETDATE() , RowVersion=newid();
update TM_WorkPosition SET UsedQuantity=0 WHERE len( WorkPositionNo)=6;
----��տ��pallet��Ϣ����Ӧ�㣺����Ϊ6
UPDATE WM_Pallet SET MatchPalletCode='', MatchPalletName='',UniqueId='',ProductCount=0,StorageQuantity=0,InFrozenQuantity=0,OutFrozenQuantity=0
    ,ProductPosition='',BrandCodes='',BrandNames='',PalletTypeCode='',PalletTypeName='' WHERE len(LocationCode)=6;

delete FROM WM_Storage WHERE LEN(LocationCode)=6;
