USE [FusionFLK]

SELECT Active&1 FROM BI_Product;
select * from BI_Product where charindex(SUBSTRING(ProductCode,18,3),Weight)>0 and len(SUBSTRING(ProductCode,18,3))=len(Weight);
SELECT SUBSTRING(ProductCode, 19, 3), Productcode FROM BI_PRODUCT;
SELECT LEN(ProductCode) FROM BI_Product;
SELECT * FROM BI_Product;-- WHERE ProductCode='5300001004689557101002014036';

SELECT * FROM BI_Shift;

SELECT * FROM WM_Location WHERE LocationCode='02-21-02';
SELECT * FROM WM_Storage;
SELECT * FROM WM_Storage WHERE ProductCode='0000321004789656101002013036';
SELECT * FROM WM_Storage WHERE LocationCode='02-21-02';

SELECT * FROM WM_OutBillAllot;

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

----
SELECT * FROM SYS_Area;
SELECT * FROM SYS_Module;
SELECT * FROM SYS_Function;
SELECT * FROM SYS_Function WHERE Id='6D2A24AE-AC5F-1214-8D84-6BBF920161D3';
SELECT * FROM SYS_Function WHERE NAME LIKE '%刷新%';
SELECT * FROM SYS_Permissions WHERE FunctionId in (SELECT Id FROM SYS_Function WHERE NAME LIKE '%刷新%');
SELECT * FROM SYS_Role WHERE NAME LIKE '%mes%';