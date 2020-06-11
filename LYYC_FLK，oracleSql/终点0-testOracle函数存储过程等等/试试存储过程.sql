
create or replace procedure pro_test
(sex IN VARCHAR2, V_RESULT OUT VARCHAR2)
AS
  countNum number(10);
BEGIN
  countNum := 1;
  dbms_output.put_line(sex);
  
  UPDATE WM_REGIONU SET ACTIVEU=0;
  --SELECT ACTIVEU INTO countNum FROM BI_BRANDU;
  
  Exception when others then
    raise;
  V_RESULT := '^_^';
END;
/
set serveroutput on;
DECLARE 
  V_RESULT VARCHAR2(50);
BEGIN
  pro_test('2323', V_RESULT);
  dbms_output.put_line(V_RESULT);
  commit;
  Exception when others then
    rollback;
    raise;
END;


      