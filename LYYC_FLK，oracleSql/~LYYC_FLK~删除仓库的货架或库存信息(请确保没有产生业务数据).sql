
----清空业务数据
delete from TM_TASKU;
delete from TM_TASK_HISTORYU;

DELETE FROM WM_STORAGEU;
DELETE FROM WM_PALLETU;
DELETE FROM WM_LOCATIONU;
DELETE FROM WM_SHELFU;
delete from WM_REGIONU;
delete from WM_WAREHOUSEU;
delete from TM_WORK_EQUIPMENTU;
delete from TM_OPERATION_EQUIPMENTU;
DELETE FROM TM_WORK_PATH_NODEU;
delete from TM_WORK_POSITIONU;
delete from TM_WORK_PATHU;
delete from TM_WORK_REGIONU;
delete from SYS_WAREHOUSE_CONFIGU;
delete from SYS_DBINITIALIZEU;


COMMIT WORK;
/
set serveroutput on;
create or replace function f_A2(rowCount integer)
return varchar2
is
  temp varchar2(30);
begin
  if (rowCount > 0) then
    dbms_output.put_line(rowCount); --如果有错误就提示。
  end if;
  return 0;
end;

/
declare
  rowCount Integer;
  v_Temp varchar2(50);
begin
	select count(*) into rowCount from tm_tasku;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from tm_task_historyu;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from wm_storageu;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from wm_palletu;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from wm_locationu;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from wm_shelfu;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from wm_regionu;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from wm_warehouseu;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from tm_work_equipmentu;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from tm_operation_equipmentu;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from TM_WORK_PATH_NODEU;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from tm_work_positionu;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from tm_work_pathu;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from tm_work_regionu;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from sys_warehouse_configu;
  v_Temp := f_A2(rowCount);
	select count(*) into rowCount from sys_dbinitializeu;
  v_Temp := f_A2(rowCount);
end;
/
