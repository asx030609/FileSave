
create or replace function F_A1
return varchar2
is
begin
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
  commit;
  Exception when others then
    rollback;
    raise;
end;
/
drop function F_A1;



create or replace function F_A2(V_TEMP VARCHAR2)
return varchar2
is
begin
  --
  return V_TEMP;
  Exception when others then
    raise;
end;
/
set serveroutput on;
declare
  v_temp varchar2(50);
begin
  v_temp := F_A2('TEST');
  dbms_output.put_line(v_temp);
  commit;
  Exception when others then
    rollback;
    raise;
end;