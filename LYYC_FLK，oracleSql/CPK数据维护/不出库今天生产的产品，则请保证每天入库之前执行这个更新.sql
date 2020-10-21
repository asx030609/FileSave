create or replace procedure pro_EveryDaySetLocationStatus
AS
begin
  ----将现有库存的货位设置成禁入
  UPDATE WM_LOCATIONU SET LOCATION_STATUSU='3' WHERE LOCATION_CODEU IN 
   (SELECT LOCATION_CODEU FROM WM_STORAGEU WHERE LENGTH(LOCATION_CODEU)=8) --//空托盘也可以不用改AND PRODUCT_CODEU!='10000') 
   AND LENGTH(LOCATION_CODEU)=8 AND LOCATION_STATUSU!='0' --货位被禁用了就保持原样
   ;
  ----把空货位设置成禁出
  UPDATE WM_LOCATIONU SET LOCATION_STATUSU='2' WHERE LOCATION_CODEU NOT IN (SELECT LOCATION_CODEU FROM WM_STORAGEU) AND LENGTH(LOCATION_CODEU)=8 AND LOCATION_STATUSU!='0';

  Exception when others then
    raise;
end;
/
set serveroutput on;
declare
  v_temp varchar2(50);
begin
  pro_EveryDaySetLocationStatus();
  commit;
  Exception when others then
    rollback;
    raise;
end;
/

