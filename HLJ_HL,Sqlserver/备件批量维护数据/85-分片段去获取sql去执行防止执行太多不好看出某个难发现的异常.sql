
--declare 

SELECT dbo.f_PlaceHolderStr(CombineSql,Param01,Param02,Param03,Param04,Param05) FROM TL_ExecuteSql where TaskType in (1,21,31,35,41) ORDER BY ID ;
SELECT dbo.f_PlaceHolderStr(CombineSql,Param01,Param02,Param03,Param04,Param05) FROM TL_ExecuteSql where TaskType in (51,61,71) ORDER BY ID ;
SELECT dbo.f_PlaceHolderStr(CombineSql,Param01,Param02,Param03,Param04,Param05) FROM TL_ExecuteSql where TaskType in (41) ORDER BY ID ;

SELECT * FROM TL_ExecuteSql where TaskType=35;
SELECT * FROM TL_ExecuteSql where TaskType=81;
SELECT * FROM TB01 WHERE 
	ProductCode='0060010071'
	--ProductCode IS NULL OR ProductName IS NULL;
SELECT Max(LocationNo) FROM TB01 WHERE (1=1) 
	--and ProductCode='0060461005'
	and LocationNo > 32;
SELECT * FROM TB01 WHERE ID > 2959
	ORDER BY ID;
	;
--SELECT * FROM FusionBJK.WM