use [FusionBJK]

SELECT * FROM WM_Pallet;
SELECT * FROM BI_ProductUnit ORDER BY ProductCode,UnitType;
--��ȡĳ�����ظ����ݵ������Ϣ
SELECT * FROM BI_ProductUnit WHERE ProductCode in
	(SELECT ProductCode FROM (SELECT ProductCode,Count(ProductCode) B1 FROM BI_ProductUnit Group by ProductCode) TB1 WHERE TB1.B1 >=2)
	ORDER BY ProductCode,UnitType;

SELECT * FROM WM_Location WHERE LocationName NOT IN (SELECT LocationName FROM TB01);
SELECT * FROM WM_Location ORDER BY LocationCode;
SELECT * FROM WM_Location WHERE LocationCode='22-63-17';
SELECT * FROM FusionBJK.DBO.WM_Location WHERE LocationName LIKE '%��%' order by LocationCode desc;
SELECT * FROM FusionBJK.DBO.WM_Location order by LocationCode desc;

SELECT * FROM TB01;
SELECT SUBSTRING(LocationName,1,2) '����',SUBSTRING(LocationName, 4,2) '����',SUBSTRING(LocationName,7,2) 'λ��',LocationName FROM TB01;
--declare @charA nvarchar(50);
--set @charA='-';
--update TB01 set LocationCode=ShelfNo+@charA+LocationNo+@charA+LayerNo;

