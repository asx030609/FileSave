SET SERVEROUTPUT ON 

DECLARE
  TYPE t_table IS TABLE OF VARCHAR2(30) INDEX BY BINARY_INTEGER;
  v_table t_table;
  v_cnt   NUMBER;
BEGIN
  v_table(1) := '1';
  v_table(2) := '3';
  v_table(3) := '9';

  v_cnt := v_table.COUNT;
  FOR i IN 1 .. v_cnt LOOP
    dbms_output.put_line(v_table(i));
    END LOOP;
END;
/
DECLARE
  -- declare fixed array
  TYPE arry_num IS VARRAY(10) OF NUMBER;
  arry_top arry_num;
BEGIN
  -- init array
  arry_top := arry_num(1,2,3);

  dbms_output.put_line(arry_top(1));
  dbms_output.put_line(arry_top(2));
END;
/
DECLARE
  -- declare fixed array ----定义固定数组
  TYPE arry_var IS VARRAY(3) OF VARCHAR2(3);  ----可容纳三个长度为3的字符串的固定数组
  arry_name arry_var;
BEGIN
  -- init array
  arry_name := arry_var('tom', 'jim','tim');

  dbms_output.put_line(arry_name(1));
  dbms_output.put_line(arry_name(2));
END;