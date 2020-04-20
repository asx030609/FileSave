
create or replace function f_A1
return varchar2
is
begin
  --'2','停止'  1,运行  e.IsCheckRealtimeStatus ? e.EquipmentStatusCode == "1" : true
	Insert into C##FUSION.EM_EQUIPMENTU (EQUIPMENT_CODEU,EQUIPMENT_NAMEU,EQUIPMENT_TYPE_CODEU,EQUIPMENT_TYPE_NAMEU,EQUIPMENT_STATUS_CODEU,EQUIPMENT_STATUS_NAMEU,IS_CAN_OUTBOUNDU,IS_CAN_INBOUNDU,IS_CHECK_REALTIME_STATUSU,CURRENT_TASK_COUNTU,MAX_TASK_COUNTU,START_TIMEU,ACTIVEU,JOB_TYPEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
	  values ('SRM01','1号堆垛机','4000','堆垛机','1','运行',1,1,1,0,0,sysdate,1,0,'1',sysdate,sysdate,SYS_GUID());
	Insert into C##FUSION.EM_EQUIPMENTU (EQUIPMENT_CODEU,EQUIPMENT_NAMEU,EQUIPMENT_TYPE_CODEU,EQUIPMENT_TYPE_NAMEU,EQUIPMENT_STATUS_CODEU,EQUIPMENT_STATUS_NAMEU,IS_CAN_OUTBOUNDU,IS_CAN_INBOUNDU,IS_CHECK_REALTIME_STATUSU,CURRENT_TASK_COUNTU,MAX_TASK_COUNTU,START_TIMEU,ACTIVEU,JOB_TYPEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
	  values ('SRM02','2号堆垛机','4000','堆垛机','1','运行',1,1,1,0,0,sysdate,1,0,'1',sysdate,sysdate,SYS_GUID());

  --
  return '^_^';
  Exception when others then
    raise;
end;
/
set serveroutput on;
declare
  v_temp varchar2(50);
begin
  v_temp := f_A1();
  dbms_output.put_line(v_temp);
  commit;
  Exception when others then
    rollback;
    raise;
end;
/
drop function f_A1;