USE [FusionPFK]
SELECT LEN(ProductCode) FROM BI_Product;
SELECT * FROM BI_Product WHERE ProductCode='5300001004689557101002014036';

SELECT * FROM WM_Location WHERE LocationCode='02-21-02';
SELECT * FROM WM_Storage;
SELECT * FROM WM_Storage WHERE ProductCode='0000321004789656101002013036';
SELECT * FROM WM_Storage WHERE LocationCode='02-21-02';

SELECT * FROM WM_OutBillAllot;


SELECT * FROM WM_OutBill WHERE OutBillNo='O202101220004'; --�˳��ⵥΪ �����̳���
SELECT * FROM WM_OutBill WHERE OutBillNo='O202101220002'; --�˳��ⵥΪ ��������
SELECT * FROM WM_OutBillDetail;

----�䷽����
SELECT * FROM BI_Formula;
SELECT * FROM BI_FormulaDetail;

----�䷽����
SELECT * FROM WM_FormulaOut;
SELECT * FROM WM_FormulaOutDetail;