SELECT NEWID();			--ED60940F-7B95-4181-AC35-0BF7F8679639
SELECT SYSDATETIME();	--2021-01-30 16:06:04.3496632
SELECT SUBSTRING('1234567890abcdef', 0, 1);		--空	----SubString是从索引1开始的
SELECT SUBSTRING('1234567890abcdef', 1, 1);		--1
SELECT SUBSTRING('1234567890abcdef', 1, 2);		--12
SELECT SUBSTRING('1234567890abcdef', 2, 1);		--2
SELECT CHARINDEX(' ', ' 123456');	--1；索引是从1开始的
SELECT CHARINDEX(' ', '123456');	--0；索引是从1开始的，假若不存在则索引为0

--1、SUBSTRING：截取字符串；
--2、CHARINDEX：查找某一字符在另一个字符串中的索引位置；
--3、REVERSE：反转某一字符串。
SELECT SUBSTRING('NAME01 COLOR01', 1, LEN('NAME01 COLOR01')-CHARINDEX(' ', REVERSE('NAME01 COLOR01'))); --结果为NAME01；--从名称+空格+颜色的字符串中去掉颜色
SELECT LEN('NAME01 COLOR01')-CHARINDEX(' ', REVERSE('NAME01 COLOR01'));		--6
SELECT CHARINDEX(' ', REVERSE('NAME01 COLOR01'));	--8
SELECT REVERSE('NAME01 COLOR01');		--10ROLOC 10EMAN

DECLARE @LEN_ INT;
set @LEN_ = 5;
SELECT RIGHT(replicate('0', @LEN_)+'2', @LEN_);	----用0左补足到@LEN_位
SELECT RIGHT(replicate('0', 5)+'2', 5);	----用0左补足到5位
SELECT LEFT('2' + replicate('0', 4), 4);		----用0又补足到4位

----*****分组，选择前面几列
----SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY GETDATE()) AS ROWNUM,TB_A.* FROM WM_Location TB_A ORDER BY LocationCode) TB_B 
----	WHERE TB_B.ROWNUM <=10;		----报错：除非另外还指定了 TOP、OFFSET 或 FOR XML，否则，ORDER BY 子句在视图、内联函数、派生表、子查询和公用表表达式中无效。
----*****上个语句需要使用Top才行，原因就是针对一个表的SELECT其实并不是返回一个表，而是一个游标。来源于：https://blog.csdn.net/qq_39569480/article/details/104655485
SELECT TOP 10 TB_A.* FROM  WM_Location TB_A ORDER BY LocationCode
----*****试试 这个 oracle 和 sql server 应该都是支持的
select * FROM  WM_Location order by LocationCode desc OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;