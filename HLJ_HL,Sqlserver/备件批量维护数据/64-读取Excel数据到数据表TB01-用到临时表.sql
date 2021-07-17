USE [TestDB]
--/*读取Excel数据到数据表TB01
----读取数据到临时表#type
drop table #type;
select  * into #type  from  ----将获取的数据插入临时表
	OPENROWSET ('Microsoft.ACE.OLEDB.12.0'
	, 'Excel 12.0;HDR=Yes;IMEX=1;DATABASE=E:\repository\FileSaveV1\HLJ_HL,Sqlserver\备件批量维护数据\default(2)-V0.xls', 新的工作表_1$);

----//相关可能关联的外键表数据
TRUNCATE TABLE TB01;

----//插入数据
insert   into  TB01(LocationName,ProductCode,ProductName,ModelName,UnitName,Quantity) 
SELECT LocationName,ProductCode,ProductName,ModelName,UnitName,Quantity FROM #type;
drop table #type;
