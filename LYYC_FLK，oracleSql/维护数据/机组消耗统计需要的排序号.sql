
SELECT *FROM BI_PRODUCTU;



UPDATE BI_MATCH_PALLETU SET REMARKU='4'; --将所有都置位最大
UPDATE BI_MATCH_PALLETU SET REMARKU='1' WHERE MATCH_PALLET_CODEU LIKE '%1002%';
UPDATE BI_MATCH_PALLETU SET REMARKU='2' WHERE MATCH_PALLET_CODEU LIKE '%1001%';
UPDATE BI_MATCH_PALLETU SET REMARKU='3' WHERE MATCH_PALLET_CODEU LIKE '%1003%';

SELECT * FROM BI_MATCH_PALLETU ORDER BY REMARKU;


UPDATE BI_PRODUCTU SET SORT_NOU=99;
UPDATE BI_PRODUCTU SET SORT_NOU=1 WHERE PRODUCT_NAMEU LIKE '%盒包装纸%';
UPDATE BI_PRODUCTU SET SORT_NOU=2 WHERE PRODUCT_NAMEU LIKE '%条包装纸%';
UPDATE BI_PRODUCTU SET SORT_NOU=3 WHERE PRODUCT_NAMEU LIKE '%复合内衬纸%';
UPDATE BI_PRODUCTU SET SORT_NOU=4 WHERE PRODUCT_NAMEU LIKE '%白色框架纸%';
UPDATE BI_PRODUCTU SET SORT_NOU=5 WHERE PRODUCT_NAMEU LIKE '%120%高收缩膜%';
UPDATE BI_PRODUCTU SET SORT_NOU=6 WHERE PRODUCT_NAMEU LIKE '%345%高收缩膜%';
UPDATE BI_PRODUCTU SET SORT_NOU=7 WHERE PRODUCT_NAMEU LIKE '%拉线%';
UPDATE BI_PRODUCTU SET SORT_NOU=8 WHERE PRODUCT_NAMEU LIKE '%横纹卷烟纸%';
UPDATE BI_PRODUCTU SET SORT_NOU=9 WHERE PRODUCT_NAMEU LIKE '%烫印接装纸%';

SELECT * FROM BI_PRODUCTU ORDER BY SORT_NOU;
/*
SELECT * FROM BI_PRODUCTU WHERE PRODUCT_CODEU IN (SELECT PRODUCT_CODEU FROM BI_MATCH_PALLET_DETAILU WHERE MATCH_PALLET_CODEU LIKE '%1002%');
SELECT * FROM BI_PRODUCTU WHERE PRODUCT_NAMEU LIKE '%盒包装纸%';
SELECT * FROM BI_PRODUCTU WHERE PRODUCT_NAMEU LIKE '%条包装纸%';
SELECT * FROM BI_PRODUCTU WHERE PRODUCT_NAMEU LIKE '%复合内衬纸%';
SELECT * FROM BI_PRODUCTU WHERE PRODUCT_NAMEU LIKE '%白色框架纸%';
SELECT * FROM BI_PRODUCTU WHERE PRODUCT_NAMEU LIKE '%120%高收缩膜%';
SELECT * FROM BI_PRODUCTU WHERE PRODUCT_NAMEU LIKE '%345%高收缩膜%';
SELECT * FROM BI_PRODUCTU WHERE PRODUCT_NAMEU LIKE '%拉线%';
SELECT * FROM BI_PRODUCTU WHERE PRODUCT_NAMEU LIKE '%横纹卷烟纸%';
SELECT * FROM BI_PRODUCTU WHERE PRODUCT_NAMEU LIKE '%烫印接装纸%';
--*/
