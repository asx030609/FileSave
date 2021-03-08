
----//相关可能关联的外键表数据
TRUNCATE TABLE DMT_TAG;
--TRUNCATE TABLE DMT_GROUP;
----对于由 FOREIGN KEY 约束引用的表，不能使用 TRUNCATE TABLE，而应使用不带 WHERE 子句的 DELETE 语句。由于 TRUNCATE TABLE 不记录在日志中，所以它不能激活触发器。
DELETE FROM DMT_Group;
--TRUNCATE TABLE DMT_DataServer;

----读取数据到临时表#type
select * into #type  from  ----将获取的数据插入临时表
	OPENROWSET ('Microsoft.ACE.OLEDB.12.0'
	, 'Excel 12.0;HDR=Yes;IMEX=1;DATABASE=E:\repository\FileSaveV1\HLJ_HL,Sqlserver\维护数据\oracle\DMT_GROUPU.xls', sheet1$);
SELECT * FROM #type;
--/*
----//插入数据
insert INTO DMT_Group (
    GroupCode,
    ServerCode,
    GroupName,
    UpdateRate,
    DeadBand,
    Active,
    Remark,
    CreateTime,
    UpdateTime,
    RowVersion
) 
SELECT   GroupCode,
    ServerCode,
    GroupName,
    UpdateRate,
    DeadBand,
    Active,
    Remark,
	CONVERT(datetime, CreateTime, 101),
	CONVERT(datetime, UpdateTime, 101),
    NEWID() FROM #type;
--*/
drop table #type;