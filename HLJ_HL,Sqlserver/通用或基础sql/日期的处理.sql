
----�ַ���ת����
SELECT CONVERT(datetime, '2021/1/27 20:42:39', 101); --2021-01-27 20:42:39.000
SELECT CONVERT(datetime, '2021/1/27 20:42:39', 103); --ERROR

----����ת�ַ���
DECLARE @dt datetime;
SET @dt='2021/1/27 20:42:39';
SELECT CONVERT(varchar,@dt,103); --27/01/2021
/*== ���Ǻܶ��˾������Ĵ���,�Է�������ת��ʹ�����ڵ�style��ʽ ==*/
SELECT CONVERT(varchar,'2021/1/27 20:42:39',101); --2021/1/27 20:42:39


SELECT GETDATE();