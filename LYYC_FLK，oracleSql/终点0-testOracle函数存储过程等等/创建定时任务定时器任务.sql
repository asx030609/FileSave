variable jobno number;
DECLARE 
  V_RESULT VARCHAR2(50);
begin
   --dbms_job.submit(:jobno,'pro_test;', sysdate, 'TRUNC(sysdate,''mi'') + 1/(24*60)'); --ÿһ��ִ��һ��
   dbms_job.submit(:jobno,'pro_test;', sysdate, 'TRUNC(sysdate)+1+4/(24)'); --ÿ���賿4��ִ��һ��

   commit;

end;

/
show parameter job_queue_processes;
----�������0������ִ������������޸ģ�
--alter system set job_queue_processes=10;
SELECT TO_CHAR(SYSDATE, 'yy-mm-dd hh24:mi:ss') FROM DUAL;
select job, next_date, next_sec, failures, broken from user_jobs;  ----failures��ʾʧ�ܴ���----brokenֵΪn����ʾ��ʱ���������ɹ�
----�鿴������