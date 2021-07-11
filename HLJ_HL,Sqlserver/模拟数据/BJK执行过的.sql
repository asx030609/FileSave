USE [TestDB]

SELECT * FROM TB01;
SELECT * FROM WM_Pallet;
SELECT * FROM BI_ProductUnit WHERE UnitName NOT IN (SELECT UnitName FROM TB01);

SELECT * FROM WM_Location WHERE LocationName NOT IN (SELECT LocationName FROM TB01);

SELECT * FROM TB01;
SELECT SUBSTRING(LocationName,1,2) '架数',SUBSTRING(LocationName, 4,2) '层数',SUBSTRING(LocationName,7,2) '位数',LocationName FROM TB01;
--declare @charA nvarchar(50);
--set @charA='-';
--update TB01 set LocationCode=ShelfNo+@charA+LocationNo+@charA+LayerNo;