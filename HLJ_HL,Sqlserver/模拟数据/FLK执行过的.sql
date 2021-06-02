USE [FusionFLK]

SELECT Active&1 FROM BI_Product;
select * from BI_Product where charindex(SUBSTRING(ProductCode,18,3),Weight)>0 and len(SUBSTRING(ProductCode,18,3))=len(Weight);
SELECT SUBSTRING(ProductCode, 19, 3), Productcode, LEN(ProductCode) FROM BI_PRODUCT;
SELECT LEN(ProductCode) FROM BI_Product;
SELECT * FROM BI_Product;-- WHERE ProductCode='5300001004689557101002014036';

SELECT * FROM BI_Shift;

SELECT * FROM WM_Pallet WHERE InFrozenQuantity>0 OR OutFrozenQuantity > 0;

SELECT * FROM WM_Location WHERE LocationCode='01-01-01';
SELECT * FROM WM_Pallet WHERE LocationCode='01-01-01';
SELECT * FROM WM_Pallet where LocationCode in (
	SELECT LocationCode FROM WM_Storage) and MatchPalletCode ='';
SELECT * FROM WM_Storage;
SELECT * FROM WM_Storage WHERE LocationCode='01-01-01';
SELECT * FROM WM_Storage WHERE ProductCode='00003210 04789656 10100201 3036';
SELECT * FROM WM_Storage WHERE LocationCode='02-21-02';

SELECT * FROM WM_OutBillAllot;

----
SELECT * FROM TM_Task WHERE TaskStatus in ('1'); --2,完成；1,执行中；0，等待中
SELECT * FROM TM_Task WHERE TaskNo in ('389', '379', '386');
SELECT * FROM TM_Task where OriginWorkPositionNo in ('2218', '2101')
	ORDER BY TaskNo DESC;
SELECT * FROM TM_Task WHERE OriginLocationCode in (
	SELECT TargetLocationCode FROM TM_Task WHERE TaskNo in ('233', '234', '235', '260', '262', '263')	
	--这几个入库任务号对应货位不和实际匹配，有问题，所以看看是否在之后已经出库
	);
SELECT * FROM TM_Task WHERE OriginLocationCode in (
	SELECT TargetLocationCode FROM TM_Task WHERE TaskNo in ('233', '234', '235', '260', '262', '263')	--这几个入库任务号对应货位不和实际匹配，有问题，所以看看是否在之后已经出库
	
	);
--update TM_Task set TaskStatus=1 where CurrentWorkPositionNo='2213';	--1、执行中；2、完成
SELECT * FROM TM_Task WHERE CurrentWorkPositionNo='2213';

----生产计划
SELECT * FROM WM_ProductionPlan WHERE CreateTime <= CONVERT(datetime, '2021-4-21 00:00:00', 101) ORDER BY CreateTime DESC; ----计划状态是：Entered=0,Audited=1,Executing=2,Settled=3,PreExecute=4
SELECT * FROM WM_ProductionPlanDetail WHERE MachineName LIKE '9#包装机' order by CreateTime desc;
----机组呼叫
SELECT MachineCode FROM WM_MachineCall WHERE CallTime between CONVERT(datetime, '2021/5/18', 101) and  CONVERT(datetime, '2021/5/19', 101);



----作业位置
SELECT TB_A.WorkPositionNo, TB_A.WorkPositionName
	, CAST( SUBSTRING(CAST(TB_A.WorkPositionNo AS CHAR), 2,2) AS INT) 多少列
	, CAST( SUBSTRING(CAST(TB_A.WorkPositionNo AS CHAR), 4,2) AS INT) 多少层
	FROM TM_WorkPosition TB_A;


----区域、模块、功能、权限、角色
SELECT * FROM SYS_Area;
SELECT * FROM SYS_Module;
SELECT * FROM SYS_Function;
SELECT * FROM SYS_Function WHERE Id='6D2A24AE-AC5F-1214-8D84-6BBF920161D3';
SELECT * FROM SYS_Function WHERE NAME LIKE '%刷新%';
SELECT * FROM SYS_Permissions WHERE FunctionId in (SELECT Id FROM SYS_Function WHERE NAME LIKE '%刷新%');
SELECT * FROM SYS_Role WHERE NAME LIKE '%mes%';



----查询用户
SELECT * FROM Sys_user;


SELECT * FROM WM_OutBill WHERE OutBillNo='O202101220004'; --此出库单为 空托盘出库
SELECT * FROM WM_OutBill WHERE OutBillNo='O202101220002'; --此出库单为 调剂出库
SELECT * FROM WM_OutBillDetail;

----配方管理
SELECT * FROM BI_Formula;
SELECT * FROM BI_FormulaDetail;

----配方出库
SELECT * FROM WM_FormulaOut;
SELECT * FROM WM_FormulaOutDetail;

SELECT * FROM SYS_Parameter;
SELECT * FROM SYS_Parameter WHERE ParameterValue LIKE '%海林%';

SELECT * FROM SYS_Dictionary WHERE DictionaryName LIKE '%海林%';
SELECT * FROM SYS_DictionaryDetail WHERE [Name] LIKE '%海林%';
SELECT * FROM SYS_DictionaryGroup;

-----
/* 将TM_WorkPathNode表中的AGV-SRM01路径编码替换为AGV-SRM001
Declare @orgin VARCHAR(20);
set @orgin='AGV-SRM01';
Declare @orginTo VARCHAR(20);
set @orginTo='AGV-SRM001';
ALTER TABLE TM_WorkPathNode NOCHECK CONSTRAINT FK_BEE7C009898EA9738DCCCE2B;
UPDATE TM_WorkPath SET WorkPathCode=@orginTo WHERE WorkPathCode=@orgin;
UPDATE TM_WorkPathNode SET WorkPathCode=@orginTo WHERE WorkPathCode=@orgin;
ALTER TABLE TM_WorkPathNode CHECK CONSTRAINT FK_BEE7C009898EA9738DCCCE2B;
----*/