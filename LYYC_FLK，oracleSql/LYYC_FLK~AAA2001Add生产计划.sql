
delete from WM_PRODUCTION_PLANU;
delete from WM_PRODUCTION_PLAN_DETAILU;

commit;
----PRODUCTION_PLAN_STATUSU	    {	        Entered = 0,	        Audited = 1,	        Executing = 2,	        Settled=3	    }	
--insert into C##FUSION.WM_PRODUCTION_PLANU(PRODUCTION_PLAN_NOU, ORIGIN_PLAN_NOU, PLAN_BEGIN_TIMEU, PLAN_END_TIMEU, MAKERU, MAKE_TIMEU, AUDITORU, MOVE_BILL_NOU, AUDIT_TIMEU, PRODUCTION_PLAN_STATUSU, PRODUCTION_PLAN_ORIGINU, CREATE_TIMEU, UPDATE_TIMEU, ROW_VERSIONU)
--values ( 'test' , null,  to_date('2019/11/14 8:30:00', 'yyyy-mm-dd hh24:mi:ss'),to_date('2019/11/14 16:30:00', 'yyyy-mm-dd hh24:mi:ss'),  'admin' ,  sysdate ,  '' , null, null,  '0' ,  '0' ,  sysdate ,  sysdate ,  SYS_GUID());
--
insert into C##FUSION.WM_PRODUCTION_PLANU(PRODUCTION_PLAN_NOU, ORIGIN_PLAN_NOU, PLAN_BEGIN_TIMEU, PLAN_END_TIMEU, MAKERU, MAKE_TIMEU, AUDITORU, MOVE_BILL_NOU, AUDIT_TIMEU, PRODUCTION_PLAN_STATUSU, PRODUCTION_PLAN_ORIGINU, CREATE_TIMEU, UPDATE_TIMEU, ROW_VERSIONU)
values ( 'test' , null,  to_date('2019/11/14 16:30:00', 'yyyy-mm-dd hh24:mi:ss'),to_date('2019/11/15 00:30:00', 'yyyy-mm-dd hh24:mi:ss'),  'admin' ,  sysdate ,  '' , null, null,  '0' ,  '0' ,  sysdate ,  sysdate ,  SYS_GUID());
--
--insert into C##FUSION.WM_PRODUCTION_PLANU(PRODUCTION_PLAN_NOU, ORIGIN_PLAN_NOU, PLAN_BEGIN_TIMEU, PLAN_END_TIMEU, MAKERU, MAKE_TIMEU, AUDITORU, MOVE_BILL_NOU, AUDIT_TIMEU, PRODUCTION_PLAN_STATUSU, PRODUCTION_PLAN_ORIGINU, CREATE_TIMEU, UPDATE_TIMEU, ROW_VERSIONU)
--values ( 'test' , null,  to_date('2019/11/14 00:30:00', 'yyyy-mm-dd hh24:mi:ss'),to_date('2019/11/14 08:30:00', 'yyyy-mm-dd hh24:mi:ss'),  'admin' ,  sysdate ,  '' , null, null,  '0' ,  '0' ,  sysdate ,  sysdate ,  SYS_GUID());
--
insert into C##FUSION.WM_PRODUCTION_PLAN_DETAILU(IDU, PRODUCTION_PLAN_NOU, SERIAL_NUMBERU, TEAM_CODEU, TEAM_NAMEU, MACHINE_CODEU, MACHINE_NAMEU, BRAND_CODEU, BRAND_NAMEU, ORIGIN_WORK_NOU, PRODUCTION_PLAN_DETAIL_STATUSU, PRODUCTION_BEGIN_TIMEU, PRODUCTION_END_TIMEU, CREATE_TIMEU, UPDATE_TIMEU, ROW_VERSIONU)
values ( SYS_GUID(),  'test' ,  '2' ,  'T0001' ,  '¼×°à' ,  'J102' ,  '2#¾íÑÌ»ú' ,  '2' ,  'ÂË°ô' , null,  '0' , null, null,  sysdate ,  sysdate ,  SYS_GUID());
----
update C##FUSION.WM_PRODUCTION_PLANU
set AUDITORU =  'admin' , AUDIT_TIMEU =  sysdate , PRODUCTION_PLAN_STATUSU =  '1' , UPDATE_TIMEU =  sysdate 
where ((PRODUCTION_PLAN_NOU =  'test' ));

commit;


