
create or replace function F_A1
return varchar2
is
    V_TEMP VARCHAR2(500); ----也可不定义变量
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


----带参数函数
create or replace function F_A2(V_TEMP VARCHAR2)
return varchar2
is
    V_TEMP01 VARCHAR2(500); 
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