
----//相关可能关联的外键表数据
TRUNCATE TABLE DMT_Tag;

----读取数据到临时表#type
select * into #type  from  ----将获取的数据插入临时表
	OPENROWSET ('Microsoft.ACE.OLEDB.12.0'
	, 'Excel 12.0;HDR=Yes;IMEX=1;DATABASE=E:\repository\FileSaveV1\HLJ_HL,Sqlserver\维护数据\oracle\DMT_TAGU.xls', sheet1$);
SELECT * FROM #type;
--/*
----//插入数据
insert INTO DMT_Tag (
    TagCode,
    GroupCode,
    ServerCode,
    TagName,
    DataType,
    DataSize,
    DataCount,
    Address,
    ClassName,
    DisplayOrder,
    Archive,
    Cycle,
    AutoSync,
    Active,
    ReadOnly,
    Remark,
    CreateTime,
    UpdateTime,
    RowVersion
) 
SELECT    TagCode,
    GroupCode,
    ServerCode,
    TagName,
    DataType,
    DataSize,
    DataCount,
    Address,
    ClassName,
    DisplayOrder,
    Archive,
    Cycle,
    AutoSync,
    Active,
    ReadOnly,
    Remark,
	CONVERT(datetime, CreateTime, 101),
	CONVERT(datetime, UpdateTime, 101),
    NEWID() FROM #type;
--*/
drop table #type;