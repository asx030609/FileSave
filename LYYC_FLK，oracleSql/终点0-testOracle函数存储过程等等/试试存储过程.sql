
create or replace procedure pro_test
(sex VARCHAR2)
AS
  countNum number(10);
BEGIN
  countNum := 1;
  dbms_output.put_line(sex);
END;
/
set serveroutput on;
BEGIN
  pro_test('2323');
END;


      