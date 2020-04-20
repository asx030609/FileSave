--将作业位置和名称修改成与pallet_positionu一致
--把那些要改数据依据的标志位找出来，只有2,4，6,8机组的编号要改
/*
SELECT *
  FROM WM_MACHINE_PALLETU machinPallet
  INNER JOIN TM_WORK_POSITIONU workPosition ON workPosition.WORK_POSITION_NOU =  machinPallet.WORK_POSITION_NOU
  WHERE MACHINE_CODEU = 'J1'||LPAD('2',2,'0') OR MACHINE_CODEU='B2' || LPAD('2',2,'0')
  ORDER BY workPosition.WORK_POSITION_NOU;
--*/
--更新wm_machince_palletu的work_position_no；Name就不要改了，这是机器最终送到的位置，AGV也只认这个编号，这个不能改
--UPDATE WM_MACHINE_PALLETU SET WORK_POSITION_NOU='[NEW WORK_POSITION_NOU]'
-- WHERE MACHINE_CODEU = 'J1'||LPAD('2',2,'0') OR MACHINE_CODEU='B2' || LPAD('2',2,'0') ;
--依据相应内容更新TM_work_positionu
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
      dbms_output.put_line('V_EX01：'||V_EX01);
      dbms_output.put_line('V_EX02：'||V_EX02);
      SELECT WORK_POSITION_NAMEU INTO V_TEMP FROM TM_WORK_POSITIONU WHERE WORK_POSITION_NOU = V_EX01;
      dbms_output.put_line('V_TEMP：'||V_TEMP);
      UPDATE TM_WORK_POSITIONU SET WORK_POSITION_NAMEU=(SELECT WORK_POSITION_NAMEU FROM  TM_WORK_POSITIONU WHERE WORK_POSITION_NOU =V_EX02) WHERE WORK_POSITION_NOU = V_EX01; 
      UPDATE TM_WORK_POSITIONU SET WORK_POSITION_NAMEU=V_TEMP WHERE WORK_POSITION_NOU = V_EX02; --因为是对参照字段的其他字段操作，可以直接替换
      --*/
      
      --/*
  V_TEMP := '9999';
  SELECT COUNT(*) INTO V_EXISTS_ROW FROM WM_MACHINE_PALLETU WHERE WORK_POSITION_NOU = V_EX01;
  IF (1 =V_EXISTS_ROW ) THEN
    UPDATE WM_MACHINE_PALLETU SET WORK_POSITION_NOU=V_TEMP WHERE WORK_POSITION_NOU = V_EX01; --防止作业位置相同，导致后面找不到
  END IF;
  V_EXISTS_ROW := 0;
  
  SELECT COUNT(*) INTO V_EXISTS_ROW FROM WM_MACHINE_PALLETU WHERE WORK_POSITION_NOU = V_EX02;
  IF (1 =V_EXISTS_ROW ) THEN
    UPDATE WM_MACHINE_PALLETU SET WORK_POSITION_NOU=V_EX01 WHERE WORK_POSITION_NOU = V_EX02; --防止作业位置相同，导致后面找不到
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
  dbms_output.put_line('返回值：'||F_01('102005','102001'));
  dbms_output.put_line('返回值：'||F_01('102004','102002'));
  
  dbms_output.put_line('返回值：'||F_01('104005','104001'));
  dbms_output.put_line('返回值：'||F_01('104004','104002'));
  
  dbms_output.put_line('返回值：'||F_01('106005','106001'));
  dbms_output.put_line('返回值：'||F_01('106004','106002'));
  
  dbms_output.put_line('返回值：'||F_01('108005','108001'));
  dbms_output.put_line('返回值：'||F_01('108004','108002'));
  COMMIT WORK;
EXCEPTION
WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;