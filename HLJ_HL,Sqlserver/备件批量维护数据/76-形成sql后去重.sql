
----����һ�����ݱ�����ͬ���ṹ����������
select * into TL_ExecuteSql_V0 from TL_ExecuteSql where 1=2;
----��ȥ�ص����ݿ������±�
set IDENTITY_INSERT TL_ExecuteSql_V0 ON    --��Ҫ����IDENTITY_INSERTΪON���ܳɹ�
go
INSERT INTO TL_ExecuteSql_V0(id)
	SELECT id from TL_ExecuteSql WHERE ID IN( SELECT mIN(ID) FROM TL_ExecuteSql GROUP BY CombineSql,Param02,Param02,Param03,Param04,Param05);
go
set IDENTITY_INSERT TL_ExecuteSql_V0 ON    --��Ҫ����IDENTITY_INSERTΪON���ܳɹ�
go
SELECT * FROM TL_ExecuteSql_V0;