--������������壬�ṩ��������ݵ�ʵ�֣��ʹ洢���̡�����������һ��
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
----���ó����
DECLARE
  v_sal varchar2(20);
BEGIN
    package_me.PRO_EMP_SELECT(7788);                --���÷�ʽ�͵��ô洢���̷�ʽһ����������Ҫ�ڴ洢����ǰ��ӳ������
    v_sal := package_me.FUN_EMP_SELECT(7788);       --���÷�ʽ�͵��ú�����ʽһ����������Ҫ�ں���ǰ��ӳ������
    dbms_output.put_line(v_sal);
END;