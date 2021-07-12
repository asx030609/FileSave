
--declare 

SELECT dbo.f_PlaceHolderStr(CombineSql,Param01,Param02,Param03,Param04,Param05) FROM TL_ExecuteSql where TaskType in (1,21,31,41) ORDER BY ID ;
SELECT dbo.f_PlaceHolderStr(CombineSql,Param01,Param02,Param03,Param04,Param05) FROM TL_ExecuteSql where TaskType in (51,61,71) ORDER BY ID ;
SELECT dbo.f_PlaceHolderStr(CombineSql,Param01,Param02,Param03,Param04,Param05) FROM TL_ExecuteSql where TaskType in (81) ORDER BY ID ;

SELECT * FROM TL_ExecuteSql where TaskType=71;
SELECT * FROM TL_ExecuteSql where TaskType=81;
SELECT * FROM TB01 WHERE (1=1) 
	--and ProductCode='0060461005'
	and LocationNo > 32
	;
--SELECT * FROM FusionBJK.WM