
 
--/*
----oracle�����ת��ʱ�䣿
SELECT TO_CHAR(SYSDATE, 'yy-mm-dd hh24:mi:ss') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'yymmddhh24miss') FROM DUAL;
SELECT to_date('2019/11/14 16:30:00', 'yyyy-mm-dd hh24:mi:ss') FROM DUAL;
SELECT to_date('2019/11/14', 'yyyy-mm-dd') FROM DUAL;
SELECT to_date('2019/9/1 0:00:00', 'yyyy-mm-dd hh24:mi:ss') FROM DUAL;
--*/

SELECT 'Year' AS truncType , TRUNC( SYSDATE, 'YYYY' ) FROM DUAL; --//Year	01-1�� -20
SELECT 'Quarter' AS truncType, TRUNC( SYSDATE, 'Q' ) FROM DUAL; --//Quarter	01-4�� -20
SELECT 'Month' AS truncType, TRUNC( SYSDATE, 'MM' ) FROM DUAL; --//Month	01-6�� -20
SELECT 'Week' AS truncType, TRUNC( SYSDATE, 'W' ) FROM DUAL;  --//Week	08-6�� -20
SELECT 'Day' AS truncType, TRUNC( SYSDATE, 'D' ) FROM DUAL; --//Day	14-6�� -20
SELECT 'Hour' AS truncType, TRUNC( SYSDATE, 'HH' ) FROM DUAL; --//Hour	15-6�� -20
SELECT 'Year' AS truncType , TO_CHAR(TRUNC( SYSDATE, 'YYYY' ), 'yy-mm-dd hh24:mi:ss') FROM DUAL; --//Year	20-01-01 00:00:00
----����������������trunc������Ҫ��ȡ���ĸ��ط�������YYYY���ǽ�ֹ��ĳ��ĵ�һ�µ�һ��0��0��0��

----������trunc([FOR DATE])������һ��trunc([FOR RUMBER])
SELECT TRUNC��89.98, 1�� FROM DUAL; --//89.9
SELECT TRUNC��89.98, -1�� FROM DUAL; --//80