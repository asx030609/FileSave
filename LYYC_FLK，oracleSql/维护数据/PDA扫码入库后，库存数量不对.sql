
create or replace function F_A1
return varchar2
is
    V_TEMP VARCHAR2(500); ----也可不定义变量
  CURSOR emp_cursor IS 
    SELECT DISTINCT TB_A.PALLET_IDU AS PALLET_IDU FROM WM_STORAGEU TB_A WHERE LENGTH( TB_A.LOCATION_CODEU)=8 AND TB_A.PRODUCT_CODEU != 'EmptyPallet' AND CREATE_TIMEU > TRUNC( SYSDATE, 'DD' ) AND TB_A.LOCATION_CODEU != '04-25-02'
    ORDER BY TB_A.PALLET_IDU;
  CURS_ROW emp_cursor%ROWTYPE;
begin
  for emp_data in emp_cursor
  LOOP
    V_TEMP := emp_data.PALLET_IDU;
    UPDATE WM_STORAGEU SET STORAGE_QUANTITYU=STORAGE_QUANTITYU*(SELECT TRANSFER_RATEU FROM BI_PRODUCT_UNITU WHERE PRODUCT_CODEU=WM_STORAGEU.PRODUCT_CODEU AND UNIT_TYPEU='2') WHERE PALLET_IDU=V_TEMP;
    UPDATE WM_PALLETU SET STORAGE_QUANTITYU=(SELECT SUM(STORAGE_QUANTITYU) FROM (SELECT STORAGE_QUANTITYU FROM WM_STORAGEU WHERE PALLET_IDU=V_TEMP ))  WHERE IDU=V_TEMP;
    dbms_output.put_line(V_TEMP);
  END LOOP;
  return '^_^';
  Exception when others then
    raise;
end;
/
set serveroutput on;
declare
  v_temp varchar2(50);
begin
  v_temp := F_A1();
  dbms_output.put_line(v_temp);
  --commit;
  Exception when others then
    rollback;
    raise;
end;
/
drop function F_A1;
