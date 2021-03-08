----读取数据到临时表#type
select  * into #type  from  ----将获取的数据插入临时表
	OPENROWSET ('Microsoft.ACE.OLEDB.12.0'
	, 'Excel 12.0;HDR=Yes;IMEX=1;DATABASE=E:\repository\FileSaveV1\HLJ_HL,Sqlserver\维护数据\oracle\DMT_DATA_SERVERU.xls', sheet1$);

----//相关可能关联的外键表数据
TRUNCATE TABLE DMT_TAG;
--TRUNCATE TABLE DMT_GROUP;
----对于由 FOREIGN KEY 约束引用的表，不能使用 TRUNCATE TABLE，而应使用不带 WHERE 子句的 DELETE 语句。由于 TRUNCATE TABLE 不记录在日志中，所以它不能激活触发器。
DELETE FROM DMT_Group;
DELETE FROM DMT_DataServer;--TRUNCATE TABLE DMT_DataServer;

----//插入数据
insert   into  DMT_DataServer(
	ServerCode,
    ServerName,
    DataDriverName,
    ServerArguments,
    Test,
    ClassName,
    Active,
    CreateTime,
    UpdateTime,
    RowVersion) 
SELECT ServerCode,
    ServerName,
    DataDriverName,
    ServerArguments,
    Test,
    ClassName,
    Active,
    CreateTime,
    UpdateTime,
    NEWID() FROM #type;
	
drop table #type;