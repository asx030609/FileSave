use [FusionFLK]


declare @V_LoctCode varchar(50);
set @V_LoctCode = '01-01-01';

UPDATE WM_Pallet SET MatchPalletCode='', MatchPalletName='',UniqueId='',ProductCount=0,StorageQuantity=0,InFrozenQuantity=0,OutFrozenQuantity=0
      ,ProductPosition='',BrandCodes='',BrandNames='',PalletTypeCode='',PalletTypeName='' where LocationCode =@V_LoctCode;
delete FROM WM_Storage where LocationCode=@V_LoctCode;

