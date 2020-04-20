--创建程序包主体，提供程序包内容的实现，和存储过程、函数的声明一致
CREATE OR REPLACE PACKAGE BODY PACKAGE_ME IS
  PROCEDURE PRO_EMP_SELECT(ENO NUMBER) AS
    --V_NAME EMP.ENAME%TYPE;
    V_NAME varchar2(20);
    V_SAL  varchar2(20);
  BEGIN
    dbms_output.put_line('3223');
  END PRO_EMP_SELECT;

  FUNCTION FUN_EMP_SELECT(ENO NUMBER) RETURN NUMBER AS
    V_SAL varchar2(20);
  BEGIN
    dbms_output.put_line('3223');
    V_SAL := '233';
    RETURN V_SAL;
  END FUN_EMP_SELECT;
END PACKAGE_ME;
/
----调用程序包
DECLARE
  v_sal varchar2(20);
BEGIN
    package_me.PRO_EMP_SELECT(7788);                --调用方式和调用存储过程方式一样，不过需要在存储过程前添加程序包名
    v_sal := package_me.FUN_EMP_SELECT(7788);       --调用方式和调用函数方式一样，不过需要在函数前添加程序包名
    dbms_output.put_line(v_sal);
END;