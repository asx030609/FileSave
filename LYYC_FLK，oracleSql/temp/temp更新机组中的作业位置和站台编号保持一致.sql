--����ҵλ�ú������޸ĳ���pallet_positionuһ��
--����ЩҪ���������ݵı�־λ�ҳ�����ֻ��2,4��6,8����ı��Ҫ��
/*
SELECT *
  FROM WM_MACHINE_PALLETU machinPallet
  INNER JOIN TM_WORK_POSITIONU workPosition ON workPosition.WORK_POSITION_NOU =  machinPallet.WORK_POSITION_NOU
  WHERE MACHINE_CODEU = 'J1'||LPAD('2',2,'0') OR MACHINE_CODEU='B2' || LPAD('2',2,'0')
  ORDER BY workPosition.WORK_POSITION_NOU;
--*/
--����wm_machince_palletu��work_position_no��Name�Ͳ�Ҫ���ˣ����ǻ��������͵���λ�ã�AGVҲֻ�������ţ�������ܸ�
--UPDATE WM_MACHINE_PALLETU SET WORK_POSITION_NOU='[NEW WORK_POSITION_NOU]'
-- WHERE MACHINE_CODEU = 'J1'||LPAD('2',2,'0') OR MACHINE_CODEU='B2' || LPAD('2',2,'0') ;
--������Ӧ���ݸ���TM_work_positionu
--UPDATE TM_WORK_POSITIONU SET WORK_POSITIONU='[NEW WORK_POSITION_NOU]' WHERE WORK_POSITION_NAMEU=[WORK_POSITION_NAMEU]' AND WORK_POSITION_NOU='WORK_POSITION_NOU';


create or replace function F_01(
    V_EX01 varchar2,
    V_EX02 varchar2
)
RETURN VARCHAR2
IS
    V_NUM_EX01 NUMBER;
    V_NUM_EX02 NUMBER;
    V_TEMP VARCHAR2(50);
    V_EXISTS_ROW NUMBER := 0;
BEGIN
  V_TEMP := '^_^';
  --V_NUM_EX01 := to_number(V_EX01);
  --V_NUM_EX02 := to_number(V_EX02);
  
      --/*
      dbms_output.put_line('V_EX01��'||V_EX01);
      dbms_output.put_line('V_EX02��'||V_EX02);
      SELECT WORK_POSITION_NAMEU INTO V_TEMP FROM TM_WORK_POSITIONU WHERE WORK_POSITION_NOU = V_EX01;
      dbms_output.put_line('V_TEMP��'||V_TEMP);
      UPDATE TM_WORK_POSITIONU SET WORK_POSITION_NAMEU=(SELECT WORK_POSITION_NAMEU FROM  TM_WORK_POSITIONU WHERE WORK_POSITION_NOU =V_EX02) WHERE WORK_POSITION_NOU = V_EX01; 
      UPDATE TM_WORK_POSITIONU SET WORK_POSITION_NAMEU=V_TEMP WHERE WORK_POSITION_NOU = V_EX02; --��Ϊ�ǶԲ����ֶε������ֶβ���������ֱ���滻
      --*/
      
      --/*
  V_TEMP := '9999';
  SELECT COUNT(*) INTO V_EXISTS_ROW FROM WM_MACHINE_PALLETU WHERE WORK_POSITION_NOU = V_EX01;
  IF (1 =V_EXISTS_ROW ) THEN
    UPDATE WM_MACHINE_PALLETU SET WORK_POSITION_NOU=V_TEMP WHERE WORK_POSITION_NOU = V_EX01; --��ֹ��ҵλ����ͬ�����º����Ҳ���
  END IF;
  V_EXISTS_ROW := 0;
  
  SELECT COUNT(*) INTO V_EXISTS_ROW FROM WM_MACHINE_PALLETU WHERE WORK_POSITION_NOU = V_EX02;
  IF (1 =V_EXISTS_ROW ) THEN
    UPDATE WM_MACHINE_PALLETU SET WORK_POSITION_NOU=V_EX01 WHERE WORK_POSITION_NOU = V_EX02; --��ֹ��ҵλ����ͬ�����º����Ҳ���
  END IF;
  V_EXISTS_ROW := 0;
  
  
  SELECT COUNT(*) INTO V_EXISTS_ROW FROM WM_MACHINE_PALLETU WHERE WORK_POSITION_NOU = V_TEMP;
  IF V_EXISTS_ROW = 1 THEN
    UPDATE WM_MACHINE_PALLETU SET WORK_POSITION_NOU=V_EX02 WHERE WORK_POSITION_NOU = V_TEMP;
  END IF;
  V_EXISTS_ROW := 0;
      --*/
  return '^_^';
END;
/
SET SERVEROUTPUT ON;
Declare
  ret varchar2(20);
Begin
  dbms_output.put_line('����ֵ��'||F_01('102005','102001'));
  dbms_output.put_line('����ֵ��'||F_01('102004','102002'));
  
  dbms_output.put_line('����ֵ��'||F_01('104005','104001'));
  dbms_output.put_line('����ֵ��'||F_01('104004','104002'));
  
  dbms_output.put_line('����ֵ��'||F_01('106005','106001'));
  dbms_output.put_line('����ֵ��'||F_01('106004','106002'));
  
  dbms_output.put_line('����ֵ��'||F_01('108005','108001'));
  dbms_output.put_line('����ֵ��'||F_01('108004','108002'));
  COMMIT WORK;
EXCEPTION
WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;