
create or replace function F_A1
return varchar2
is
    V_TEMP VARCHAR2(500); ----也可不定义变量
begin
  FOR I IN 1 .. 200 LOOP
    insert into C##FUSION.DMT_TAGU(TAG_CODEU, GROUP_CODEU, SERVER_CODEU, TAG_NAMEU, DATA_TYPEU, DATA_SIZEU, DATA_COUNTU, ADDRESSU, CLASS_NAMEU, DISPLAY_ORDERU, ARCHIVEU
    , CYCLEU, AUTO_SYNCU, ACTIVEU, READ_ONLYU, REMARKU, CREATE_TIMEU, UPDATE_TIMEU, ROW_VERSIONU)
    values ( 'ProductNameFeedback'||LPAD( I, 3, '0') ,  'ProductInfoSummary' ,  'WCSServer' ,  '产品名称反馈'||LPAD( I, 3, '0')  ,  '11' ,  '28' ,  '1' 
    ,  'DB804.STRING'||((I-1)*28) ,  '产品信息统计' ,  '1' ,  '1' ,  '1' ,  '0' ,  '1' ,  '0' ,  '' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());
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
  --commit;
  Exception when others then
    rollback;
    raise;
end;
/
drop function F_A1;