

----SELECT * FROM BI_MatchPalletDetail;
--select 'ALTER TABLE ' + b.name + ' NOCHECK CONSTRAINT ' + a.name +';'  from sysobjects a ,sysobjects b where a.xtype ='f' and a.parent_obj = b.id and b.name='BI_MatchPalletDetail'; 
--select 'ALTER TABLE ' + b.name + ' CHECK CONSTRAINT ' + a.name +';'  from sysobjects a ,sysobjects b where a.xtype ='f' and a.parent_obj = b.id and b.name='BI_MatchPalletDetail'; 
--select 'ALTER TABLE ' + b.name + ' CHECK CONSTRAINT ' + a.name +';'  from sysobjects a ,sysobjects b where a.xtype ='f' and a.parent_obj = b.id and b.name='BI_MatchPallet'; 

ALTER TABLE BI_MatchPalletDetail NOCHECK CONSTRAINT FK_68E92E16EFE7A3EFC07E927B;
--SELECT * FROM BI_MatchPalletDetail;
--/*
update BI_MatchPalletDetail SET MatchPalletCode='HEBFS-1002' WHERE MatchPalletCode='test20210415';
update BI_MatchPallet SET MatchPalletCode='HEBFS-1002' WHERE MatchPalletCode='test20210415';
update BI_MatchPalletDetail SET MatchPalletCode='HEBFS-1003' WHERE MatchPalletCode='test20210415008';
update BI_MatchPallet SET MatchPalletCode='HEBFS-1003' WHERE MatchPalletCode='test20210415008';
update BI_MatchPalletDetail SET MatchPalletCode='HEBFS-3002' WHERE MatchPalletCode='test20210415012';
update BI_MatchPallet SET MatchPalletCode='HEBFS-3002' WHERE MatchPalletCode='test20210415012';
update BI_MatchPalletDetail SET MatchPalletCode='HEBFS-2001' WHERE MatchPalletCode='test20210415013';
update BI_MatchPallet SET MatchPalletCode='HEBFS-2001' WHERE MatchPalletCode='test20210415013';

update BI_MatchPalletDetail SET MatchPalletCode='HLLZLD-1002' WHERE MatchPalletCode='test20210415002';
update BI_MatchPallet SET MatchPalletCode='HLLZLD-1002' WHERE MatchPalletCode='test20210415002';
update BI_MatchPalletDetail SET MatchPalletCode='HLLZLD-1003' WHERE MatchPalletCode='test20210415006';
update BI_MatchPallet SET MatchPalletCode='HLLZLD-1003' WHERE MatchPalletCode='test20210415006';
update BI_MatchPalletDetail SET MatchPalletCode='HLLZLD-3002' WHERE MatchPalletCode='test20210415010';
update BI_MatchPallet SET MatchPalletCode='HLLZLD-3002' WHERE MatchPalletCode='test20210415010';
update BI_MatchPalletDetail SET MatchPalletCode='HLLZLD-2001' WHERE MatchPalletCode='test20210415015';
update BI_MatchPallet SET MatchPalletCode='HLLZLD-2001' WHERE MatchPalletCode='test20210415015';

update BI_MatchPalletDetail SET MatchPalletCode='HLLZL8MG-1002' WHERE MatchPalletCode='test20210415003';
update BI_MatchPallet SET MatchPalletCode='HLLZ8MG-1002' WHERE MatchPalletCode='test20210415003';
update BI_MatchPalletDetail SET MatchPalletCode='HLLZL8MG-1003' WHERE MatchPalletCode='test20210415005';
update BI_MatchPallet SET MatchPalletCode='HLLZ8MG-1003' WHERE MatchPalletCode='test20210415005';
update BI_MatchPalletDetail SET MatchPalletCode='HLLZL8MG-3002' WHERE MatchPalletCode='test20210415009';
update BI_MatchPallet SET MatchPalletCode='HLLZ8MG-3002' WHERE MatchPalletCode='test20210415009';
update BI_MatchPalletDetail SET MatchPalletCode='HLLZL8MG-2001' WHERE MatchPalletCode='test20210415016';
update BI_MatchPallet SET MatchPalletCode='HLLZ8MG-2001' WHERE MatchPalletCode='test20210415016';

update BI_MatchPalletDetail SET MatchPalletCode='HLLZLRRY-1002' WHERE MatchPalletCode='test20210415004';
update BI_MatchPallet SET MatchPalletCode='HLLZLRRY-1002' WHERE MatchPalletCode='test20210415004';
update BI_MatchPalletDetail SET MatchPalletCode='HLLZLRRY-1002' WHERE MatchPalletCode='test20210415004';
update BI_MatchPallet SET MatchPalletCode='HLLZLRRY-1002' WHERE MatchPalletCode='test20210415004';
update BI_MatchPalletDetail SET MatchPalletCode='HLLZLRRY-3002' WHERE MatchPalletCode='test20210415011';
update BI_MatchPallet SET MatchPalletCode='HLLZLRRY-3002' WHERE MatchPalletCode='test20210415011';
update BI_MatchPalletDetail SET MatchPalletCode='HLLZLRRY-2001' WHERE MatchPalletCode='test20210415014';
update BI_MatchPallet SET MatchPalletCode='HLLZLRRY-2001' WHERE MatchPalletCode='test20210415014';

--*/
SELECT * FROM BI_MatchPallet;