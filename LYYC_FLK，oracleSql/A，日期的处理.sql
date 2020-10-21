
 
--/*
----oracle中如何转换时间？
SELECT TO_CHAR(SYSDATE, 'yy-mm-dd hh24:mi:ss') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'yymmddhh24miss') FROM DUAL;
SELECT to_date('2019/11/14 16:30:00', 'yyyy-mm-dd hh24:mi:ss') FROM DUAL;
SELECT to_date('2019/11/14', 'yyyy-mm-dd') FROM DUAL;
SELECT to_date('2019/9/1 0:00:00', 'yyyy-mm-dd hh24:mi:ss') FROM DUAL;
SELECT TO_CHAR(SYSDATE-2, 'yy-mm-dd hh24:mi:ss') FROM DUAL;
--*/

----以下结果的执行时间是2020年9月11日11:09:17
SELECT 'Year' AS truncType , TRUNC( SYSDATE, 'YYYY' ) FROM DUAL; --//Year	01-1月 -20
SELECT 'Quarter' AS truncType, TRUNC( SYSDATE, 'Q' ) FROM DUAL; --//Quarter	01-7月 -20
SELECT 'Month' AS truncType, TRUNC( SYSDATE, 'MM' ) FROM DUAL; --//Month	01-9月 -20
SELECT 'Week' AS truncType, TRUNC( SYSDATE, 'W' ) FROM DUAL;  --//Week	08-9月 -20
SELECT 'Day' AS truncType, TRUNC( SYSDATE, 'D' ) FROM DUAL; --//Day	06-9月 -20
SELECT 'Day' AS truncType, TO_CHAR(TRUNC( SYSDATE, 'DD' ), 'yy-mm-dd hh24:mi:ss') FROM DUAL; --//Day	20-09-11 00:00:00
SELECT 'Day' AS truncType, TO_CHAR(TRUNC( SYSDATE, 'DD' ) -2, 'yy-mm-dd hh24:mi:ss') FROM DUAL; --//Day	20-09-09 00:00:00
SELECT 'Hour' AS truncType, TRUNC( SYSDATE, 'HH' ) FROM DUAL; --//Hour	11-9月 -20
SELECT 'Year' AS truncType , TO_CHAR(TRUNC( SYSDATE, 'YYYY' ), 'yy-mm-dd hh24:mi:ss') FROM DUAL; --//Year	20-01-01 00:00:00
----从上面总体来看，trunc函数是要截取到哪个地方，比如YYYY就是截止到某年的第一月第一天0点0分0秒

----上面是trunc([FOR DATE])，还有一种trunc([FOR RUMBER])
SELECT TRUNC（89.98, 1） FROM DUAL; --//89.9
SELECT TRUNC（89.98, -1） FROM DUAL; --//80


