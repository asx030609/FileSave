declare
  v_num2 float;
begin
  v_num2 := 5222.2;
  dbms_output.put_line(v_num2*4);
end;
/
/*
select to_number('0123' )number1,            --converts a string to number
       trunc(to_number('0123.123'),2) number2,
       to_number('120.11','999.999') number3,
 ¡¡¡¡¡¡ to_number('1a','xxx') number4,        --converts a hex number to decimal
       to_number(100000,'xxxxxx') number5
from dual;
*/