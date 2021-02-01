
----字符串转日期
SELECT CONVERT(datetime, '2021/1/27 20:42:39', 101); --2021-01-27 20:42:39.000
SELECT CONVERT(datetime, '2021/1/27 20:42:39', 103); --ERROR

----日期转字符串
DECLARE @dt datetime;
SET @dt='2021/1/27 20:42:39';
SELECT CONVERT(varchar,@dt,103); --27/01/2021
/*== 这是很多人经常犯的错误,对非日期型转换使用日期的style样式 ==*/
SELECT CONVERT(varchar,'2021/1/27 20:42:39',101); --2021/1/27 20:42:39


SELECT GETDATE();