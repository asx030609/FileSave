/*
create or replace function FNC_A1 (VAR_TABLENAME varchar2, NUM_COUNT OUT NUMBER)
return varchar2
is
  VAR_SQL VARCHAR2(1000);
begin
  VAR_SQL := 'SELECT COUNT(*) FROM ' || VAR_TABLENAME;
  EXECUTE IMMEDIATE VAR_SQL INTO NUM_COUNT; 
  --insert into "C##FUSION"."BI_TEAMU"("TEAM_CODEU", "TEAM_NAMEU", "REMARKU", "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
--values ( 'T0004' ,  'Test' ,  '' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());
  --
  return '^_^';
  Exception when others then
    raise;
end;
/*/
create or replace function FNC_A2(IN_VAR_TABLENAMES varchar2)
return varchar2
is
  VAR_SQL VARCHAR2(1000);
  VAR_TEMP VARCHAR2(200);
  NUM_TOTAL NUMBER;
begin
  NUM_TOTAL := length(IN_VAR_TABLENAMES) / 3;
      dbms_output.put_line(NUM_TOTAL);
  for i in 0 .. (NUM_TOTAL - 1)
  LOOP
    VAR_TEMP := Get_StrArrayStrOfIndex(IN_VAR_TABLENAMES, ',', i);
    if(VAR_TEMP is not null) then
      dbms_output.put_line(VAR_TEMP);
      VAR_SQL := 'DROP TABLE ' || VAR_TEMP;
      dbms_output.put_line(VAR_SQL);
      EXECUTE IMMEDIATE VAR_SQL;
    elsif (VAR_TEMP is null) then
      dbms_output.put_line('null');
    else
      dbms_output.put_line('¿Õ×Ö·û´®');
    end if;
  END LOOP;
  return '^_^';
  Exception when others then
    raise;
end;
/
set serveroutput on;
declare
  VAR_TEMP varchar2(50);
  NUM_COUNT NUMBER;
begin
  --VAR_TEMP := FNC_A1('C##FUSION.WM_PALLETU', NUM_COUNT);
  --dbms_output.put_line(NUM_COUNT);
  VAR_TEMP := FNC_A2('BI_UNITU,BI_PRODUCTU,BI_PRODUCT_BARCODEU,BI_PRODUCT_SIZEU,BI_PRODUCT_UNITU');
  commit;
  Exception when others then
    rollback;
    raise;
end;
/
--drop function FNC_A1;
drop function FNC_A2;