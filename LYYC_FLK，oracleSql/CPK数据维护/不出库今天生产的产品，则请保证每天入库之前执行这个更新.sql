create or replace procedure pro_EveryDaySetLocationStatus
AS
begin
  ----�����п��Ļ�λ���óɽ���
  UPDATE WM_LOCATIONU SET LOCATION_STATUSU='3' WHERE LOCATION_CODEU IN 
   (SELECT LOCATION_CODEU FROM WM_STORAGEU WHERE LENGTH(LOCATION_CODEU)=8) --//������Ҳ���Բ��ø�AND PRODUCT_CODEU!='10000') 
   AND LENGTH(LOCATION_CODEU)=8 AND LOCATION_STATUSU!='0' --��λ�������˾ͱ���ԭ��
   ;
  ----�ѿջ�λ���óɽ���
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

