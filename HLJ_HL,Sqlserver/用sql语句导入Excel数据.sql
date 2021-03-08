----读取数据到临时表#type
select  * into #type  from  ----将获取的数据插入临时表
	OPENROWSET ('Microsoft.ACE.OLEDB.12.0'
	, 'Excel 12.0;HDR=Yes;IMEX=1;DATABASE=C:\Users\Administrator\Desktop\oracle\DMT_DATA_SERVERU.xls', sheet1$);
drop table #type;

----//相关可能关联的外键表数据
TRUNCATE TABLE DMT_TAG;
TRUNCATE TABLE DMT_GROUP;
TRUNCATE TABLE DMT_DataServer;

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
