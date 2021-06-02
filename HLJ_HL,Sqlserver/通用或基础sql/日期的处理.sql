
----字符串转日期
SELECT CONVERT(datetime, '2021/1/27 20:42:39', 101); --2021-01-27 20:42:39.000
SELECT CONVERT(datetime, '2021/1/27 20:42:39', 103); --ERROR

----日期转字符串
DECLARE @dt datetime;
SET @dt='2021/1/27 20:42:39';
SELECT CONVERT(varchar,@dt,103); --27/01/2021
/*== 这是很多人经常犯的错误,对非日期型转换使用日期的style样式 ==*/
SELECT CONVERT(varchar,'2021/1/27 20:42:39',101); --2021/1/27 20:42:39


SELECT GETDATE();	--2021-05-10 15:56:10.607
SELECT dateadd(day,2,GETDATE());	--2021-05-12 16:02:04.490，是当前时间的后两天，当前时间2021-05-10 16:02:04.490


-----当前时间为
SELECT GETDATE();	--2021-05-17 15:53:32.327
SELECT dateadd(day,(datepart(day,GETDATE()) - 1),'2000');	--2000-01-17 00:00:00.000
DECLARE @Date datetime;
set @Date = GETDATE();
SELECT dateadd(year,(datepart(year,@Date) - 2000),dateadd(month,(datepart(month,@Date) - 1),dateadd(day,(datepart(day,@Date) - 1),'2000')));	--2021-05-17 00:00:00.000，这是当前时间的零点