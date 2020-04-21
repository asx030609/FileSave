
create or replace function f_A1 (P_TABLENAME varchar2, P_COUNT OUT NUMBER)
return varchar2
is
  V_SQL VARCHAR2(1000);
begin
  V_SQL := 'SELECT COUNT(*) FROM ' || P_TABLENAME;
  EXECUTE IMMEDIATE V_SQL INTO P_COUNT; 
  --insert into "C##FUSION"."BI_TEAMU"("TEAM_CODEU", "TEAM_NAMEU", "REMARKU", "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
--values ( 'T0004' ,  'Test' ,  '' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());
  --
  return '^_^';
  Exception when others then
    raise;
end;
/
set serveroutput on;
declare
  v_temp varchar2(50);
  P_COUNT NUMBER;
begin
  v_temp := f_A1('C##FUSION.WM_PALLETU', P_COUNT);
  dbms_output.put_line(P_COUNT);
  commit;
  Exception when others then
    rollback;
    raise;
end;
/
drop function f_A1;