----这个机组这个班组最近时间是否要了这返库物料同类型的更迟入库的物料。
create or replace function F_A1
return varchar2
is
    V_TEMP VARCHAR2(500); ----也可不定义变量
    TYPE array_var IS VARRAY(4) OF VARCHAR2(30);
    array_storage_row array_var;
    CURSOR CURS_TMP IS
      SELECT TB_A.IDENTITY_TAGU,TB_A.STORAGE_TIMEU,TB_A.LOCATION_CODEU,TB_B.BRAND_CODESU, TB_B.PALLET_TYPE_CODEU FROM WM_STORAGEU TB_A
        INNER JOIN WM_PALLETU TB_B ON TB_B.IDU = TB_A.PALLET_IDU
        WHERE TB_A.IDENTITY_TAGU IS NOT NULL ORDER BY TB_A.LOCATION_CODEU;
    MACHINE_CODE VARCHAR2(20);
    TEAM_CODE VARCHAR2(20);
    V_BRAND_CODEU VARCHAR2(50);
    V_PALLET_TYPE_CODEU VARCHAR2(50);
    STORAGE_TIME DATE;
    TASK_NO INTEGER :=0;
    FIT_ROW_COUNT NUMBER(10,0) := 0;
begin
  FOR ROW_STORAGE IN CURS_TMP
  LOOP
    MACHINE_CODE := SUBSTR(ROW_STORAGE.IDENTITY_TAGU,1,4);
    TEAM_CODE := SUBSTR(ROW_STORAGE.IDENTITY_TAGU,6,1);
    --STORAGE_TIME := ROW_STORAGEU.STORAGE_TIMEU;
    --dbms_output.put_line(MACHINE_CODE || ' ' || TEAM_CODE);
    --dbms_output.put_line(ROW_STORAGE.STORAGE_TIMEU);
    SELECT COUNT(TASK_NOU) INTO FIT_ROW_COUNT FROM WM_MACHINE_CALLU WHERE MACHINE_CODEU=MACHINE_CODE AND TEAM_CODEU=TEAM_CODE 
      AND BRAND_CODEU=ROW_STORAGE.BRAND_CODESU AND PALLET_TYPE_CODEU=ROW_STORAGE.PALLET_TYPE_CODEU
      AND (CALL_TYPEU = 0) ----///要料GetMateril=0,///取走空托盘TakeEmptyPallet=1,///余料退库ReturnMateril=2,///余料返库BackMateril=3,///移交退料MoveHandBackMateril=4,///移交要料MoveHandGetMateril=5,///缓存移料CacheMoveMateril=6
      AND CREATE_TIMEU >= ROW_STORAGE.STORAGE_TIMEU
      --AND IDENTITY_TAGU IS NOT NULL
      AND STORAGE_TIMEU >= ROW_STORAGE.STORAGE_TIMEU
      AND CREATE_TIMEU >= TO_DATE('2021/1/16 00:00:00',  'yyyy-mm-dd hh24:mi:ss')--更新之后的
      ;
    IF FIT_ROW_COUNT > 1 THEN
      dbms_output.put_line(MACHINE_CODE || ' ' || TEAM_CODE || ' ' || ROW_STORAGE.LOCATION_CODEU || ' ' || TO_CHAR(ROW_STORAGE.STORAGE_TIMEU, 'yy-mm-dd hh24:mi:ss')
        || ' ' || ROW_STORAGE.BRAND_CODESU || ' ' || ROW_STORAGE.PALLET_TYPE_CODEU );
    END IF;
    FIT_ROW_COUNT := 0;
  END LOOP;
  return '^_^';
  Exception when others then
    raise;
end;
/
set serveroutput on;
declare
  v_temp varchar2(50);
begin
  v_temp := F_A1();
  dbms_output.put_line(v_temp);
  commit;
  Exception when others then
    rollback;
    raise;
end;
/
drop function F_A1;