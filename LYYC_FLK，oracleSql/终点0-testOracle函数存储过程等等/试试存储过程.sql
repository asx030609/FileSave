
create or replace procedure pro_test
(sex VARCHAR2)
AS
  countNum number(10);
BEGIN
  countNum := 1;
  dbms_output.put_line(countNum);
END;


      