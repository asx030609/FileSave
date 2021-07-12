
----创建一个数据表，它是同样结构但不带数据
select * into TL_ExecuteSql_V0 from TL_ExecuteSql where 1=2;
----将去重的数据拷贝到新表
set IDENTITY_INSERT TL_ExecuteSql_V0 ON    --需要设置IDENTITY_INSERT为ON才能成功
go
INSERT INTO TL_ExecuteSql_V0(id)
	SELECT id from TL_ExecuteSql WHERE ID IN( SELECT mIN(ID) FROM TL_ExecuteSql GROUP BY CombineSql,Param02,Param02,Param03,Param04,Param05);
go
set IDENTITY_INSERT TL_ExecuteSql_V0 ON    --需要设置IDENTITY_INSERT为ON才能成功
go
SELECT * FROM TL_ExecuteSql_V0;