variable jobno number;
DECLARE 
  V_RESULT VARCHAR2(50);
begin
   --dbms_job.submit(:jobno,'pro_test;', sysdate, 'TRUNC(sysdate,''mi'') + 1/(24*60)'); --每一秒执行一次
   dbms_job.submit(:jobno,'pro_test;', sysdate, 'TRUNC(sysdate)+1+4/(24)'); --每天凌晨4点执行一次

   commit;

end;

/
show parameter job_queue_processes;
----必须大于0，否则执行下面的命令修改：
--alter system set job_queue_processes=10;
SELECT TO_CHAR(SYSDATE, 'yy-mm-dd hh24:mi:ss') FROM DUAL;
select job, next_date, next_sec, failures, broken from user_jobs;  ----failures表示失败次数----broken值为n，表示定时任务启动成功
----查看进程数