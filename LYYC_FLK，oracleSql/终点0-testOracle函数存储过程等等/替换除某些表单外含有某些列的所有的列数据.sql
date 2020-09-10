
-----替换除某些表单外含有某些列的所有的列数据



create or replace function FUN_A2(V_IN_NEED_UPDATE_TBS varchar2
  , V_SET_COLS VARCHAR2, V_SET_COL_VALS VARCHAR2
  , V_WHERES VARCHAR2     ----所有表都使用这个条件，所有条件用通用分隔符，号 联合而成
  ----, V_WHERE_COLS VARCHAR2, V_WHERE_COL_VALS VARCHAR2  
  , V_IN_EXCEPT_TBS VARCHAR2)
return varchar2
is
  V_SPLIT VARCHAR2(20) := ',';
  V_UPDATE_TB VARCHAR2(20000);
  V_SQL VARCHAR2(10000);
  NUM_UPDATE_TB_COUNT NUMBER;
  NUM_SET_TB_COUNT NUMBER;
  NUM_VHERE_TB_COUNT NUMBER;
  NUM_TMP NUMBER;
  V_TMP VARCHAR2(50);
  V_TMP_SQL VARCHAR2(50);
  V_TMP01 VARCHAR2(50);
  V_TMP02 VARCHAR2(50);
  V_TMP03 VARCHAR2(50);
  V_TMP04 VARCHAR2(50);
begin
  NUM_UPDATE_TB_COUNT := GET_OCCUR_COUNT(V_IN_NEED_UPDATE_TBS, V_SPLIT);
      dbms_output.put_line(V_IN_NEED_UPDATE_TBS);
      dbms_output.put_line(NUM_UPDATE_TB_COUNT);
  for i in 0 .. (NUM_UPDATE_TB_COUNT - 1)
  LOOP
    V_TMP := Get_StrArrayStrOfIndex(V_IN_NEED_UPDATE_TBS, V_SPLIT, i);
    NUM_TMP := INSTR(V_IN_EXCEPT_TBS, V_TMP);
    if( (NUM_TMP IS NULL)) then --保证不在被排除的数据表中
      dbms_output.put_line(V_IN_EXCEPT_TBS ||'正在操作表：' || V_TMP);
      V_SQL := 'UPDATE ' || V_TMP || ' SET ';
      dbms_output.put_line(V_SQL);
      --EXECUTE IMMEDIATE V_SQL;
    ELSE
      dbms_output.put_line(V_IN_EXCEPT_TBS ||'正在操作表(ELSE)：' || V_TMP);
      continue;
    end if;
  END LOOP;
  return '^_^';
  Exception when others then
    raise;
end;
/
set serveroutput on;
declare
  VAR_TEMP varchar2(50);
  NUM_COUNT NUMBER;
begin
  VAR_TEMP := FUN_A2('WM_MACHINE_CALL_DETAILU,WM_MACHINE_HANDOVER_DETAILU'
    , 'PRODUCT_CODEU,PRODUCT_NAMEU', '03050101000000056,26.5mm*29g/m2A60CU木浆横纹防伪卷烟纸'
    , 'PRODUCT_CODEU=''03050101000000031'''
    , 'WM_MACHINE_HANDOVER_DETAILU');
  commit;
  Exception when others then
    rollback;
    raise;
end;
/
--drop function FNC_A1;
drop function FUN_A2;
