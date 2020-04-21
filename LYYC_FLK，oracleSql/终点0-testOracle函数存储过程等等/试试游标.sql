SET SERVEROUTPUT ON  


----在Fusion数据库中是可以使用的，没错误的（成功）
declare
  v_location_code varchar2(2000);
  CURSOR emp_cursor(v_location_code varchar2) IS    
    SELECT * FROM WM_LOCATIONU WHERE LOCATION_CODEU=v_location_code;
  CURS_ROW emp_cursor%ROWTYPE;
begin
  v_location_code := '02-04-01';
  for emp_data in emp_cursor(v_location_code)
  LOOP
    dbms_output.put_line(emp_data.LOCATION_CODEU);
  END LOOP;
end;
/


DECLARE    
    v_ename VARCHAR2(10);   
    v_job VARCHAR2(10);   
    CURSOR emp_cursor IS    
    SELECT USER_NAMEU,ACTIVEU FROM SYS_USERU WHERE USER_NAMEU='admin';   
BEGIN      
	OPEN emp_cursor;   
	FETCH emp_cursor INTO v_ename,v_job;   
		DBMS_OUTPUT.PUT_LINE(v_ename||','||v_job);   
	CLOSE emp_cursor;
END;
/

SET SERVEROUTPUT ON  
DECLARE    
    v_ename VARCHAR2(10);   
    v_job VARCHAR2(10);   
    CURSOR emp_cursor IS    
    SELECT USER_NAMEU,ACTIVEU FROM SYS_USERU;   
BEGIN      
  for emp_data in emp_cursor
  LOOP
    dbms_output.put_line(emp_data.USER_NAMEU);
  END LOOP;
END;
/

----带参数游标
SET SERVEROUTPUT ON  
DECLARE    
    v_input VARCHAR2(1000);   
    v_job VARCHAR2(10);   
    CURSOR emp_cursor(v_input varchar2, i_Index integer) IS
    select Get_StrArrayStrOfIndex(v_input,'$',i_Index) as v_content from dual;
BEGIN      
  v_input := '1111$2222$3333$4444$5555$666666$77777$8888$9999$10101';
  for emp_data in emp_cursor(v_input, 3)
  LOOP
    dbms_output.put_line(emp_data.v_content);
  END LOOP;
END;
/