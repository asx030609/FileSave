

UPDATE WM_Pallet SET MatchPalletCode='', MatchPalletName='',UniqueId='',ProductCount=0,StorageQuantity=0,InFrozenQuantity=0,OutFrozenQuantity=0
      ,ProductPosition='',BrandCodes='',BrandNames='',PalletTypeCode='',PalletTypeName='' where LocationCode in (
SELECT OriginLocationCode FROM TM_Task WHERE TaskStatus in ('1') and TaskNo !=397 );

delete FROM WM_Storage where LocationCode in (
SELECT OriginLocationCode FROM TM_Task WHERE TaskStatus in ('1') and TaskNo !=397 );