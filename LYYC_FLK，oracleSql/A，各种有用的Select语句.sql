

----使用count 和distinct（去重）关键bai字可以查看du数据库某列是否zhi有重复项
select count(DISTINCT(IDU)) from SYS_PARAMETERU GROUP BY IDU;

--/*查找某班已结单的工单（他们有相同的生产计划开始时间和结束）的开始结单时间和结束时间，如下的min、max
SELECT TO_CHAR( MIN(UPDATE_TIMEU), 'yy-mm-dd hh24:mi:ss'), TO_CHAR( MAX(UPDATE_TIMEU), 'yy-mm-dd hh24:mi:ss') FROM WM_PRODUCTION_PLANU 
 WHERE PLAN_BEGIN_TIMEU >= to_date('2020/06/21 8:40:00', 'yyyy-mm-dd hh24:mi:ss')
 AND PLAN_BEGIN_TIMEU <= to_date('2020/06/21 8:40:00', 'yyyy-mm-dd hh24:mi:ss')
 AND PRODUCTION_PLAN_STATUSU=3;
--*/
/*
SELECT *FROM SYS_USERU;
*/
/*----////如果结单出现异常，应该会用到如下sql语句
SELECT TB_A.PRODUCT_NAMEU,TB_A.QUANTITYU,TB_B.PRODUCTION_PLAN_NOU,TB_B.TARGET_LOCATION_CODEU FROM WM_MACHINE_CALL_DETAILU TB_A 
 LEFT JOIN WM_MACHINE_CALLU TB_B ON TB_B.IDU=TB_A.MACHINE_CALL_IDU
  WHERE TB_B.PRODUCTION_PLAN_NOU='P202006130012' AND TB_B.CALL_TYPEU='0'
  ORDER BY TB_A.MACHINE_CALL_IDU;

SELECT TB_A.TRANSFER_BILL_NOU,TB_A.TRANSFER_QUANTITYU,TB_A.SOURCE_LOCATION_CODEU,TB_A.PRODUCT_NAMEU, TB_B.CURRENT_PLANU, TB_B.NEXT_PLANU, TB_A.PALLET_POSITIONU
 FROM WM_MACHINE_HANDOVER_DETAILU TB_A
INNER JOIN WM_MACHINE_HANDOVERU TB_B ON TB_B.TRANSFER_BILL_NOU=TB_A.TRANSFER_BILL_NOU
 WHERE TB_B.CURRENT_PLANU='P202006130012' OR TB_B.NEXT_PLANU='P202006130012';
----////*/
/*
----查询一条未存放货物的盘位
SELECT * FROM (SELECT * FROM WM_PALLETU WHERE IDU NOT IN (SELECT PALLET_IDU FROM WM_STORAGEU) AND LENGTH(LOCATION_CODEU)=8 ORDER BY LOCATION_CODEU DESC) WHERE ROWNUM=1;
----查询未存放货物的盘位
SELECT DISTINCT LOCATION_CODEU FROM (SELECT * FROM WM_PALLETU WHERE IDU NOT IN (SELECT PALLET_IDU FROM WM_STORAGEU) AND LENGTH(LOCATION_CODEU)=8) ORDER BY LOCATION_CODEU DESC ;

----查询添加库存后，WM_PALLETU不为空的列
SELECT * FROM (
SELECT SYS_GUID() AS IDU, '04-24-1' AS LOCATION_CODEU, '盘位' AS PALLET_NAMEU, TB_B.MATCH_PALLET_CODEU, TB_B.MATCH_PALLET_NAMEU, '99990001' AS UNIQUE_IDU
  , COUNT(*) OVER (PARTITION  by TB_A.MATCH_PALLET_CODEU) PRODUCT_COUNTU, SUM(TB_A.WAREHOUSE_QUANTITYU) OVER (PARTITION  by TB_A.MATCH_PALLET_CODEU) AS STORAGE_QUANTITYU
  , '1' AS STORAGE_SEQUENCEU
  , '42401' AS PRODUCT_POSITIONU, TB_B.BRAND_CODESU AS BRAND_CODESU, TB_B.BRAND_NAMESU AS BRAND_NAMESU, TB_B.PALLET_TYPE_CODEU AS PALLET_TYPE_CODEU, TB_B.PALLET_TYPE_NAMEU AS PALLET_TYPE_NAMEU
  , sysdate AS CREATE_TIMEU, sysdate AS UPDATE_TIMEU
FROM BI_MATCH_PALLET_DETAILU TB_A
inner join BI_MATCH_PALLETU TB_B ON TB_B.MATCH_PALLET_CODEU = TB_A.MATCH_PALLET_CODEU WHERE TB_A.MATCH_PALLET_CODEU='HQQMG-1002' ORDER BY TB_A.MATCH_PALLET_CODEU DESC
) WHERE ROWNUM=1;
SELECT TB_A.PRODUCT_CODEU,TB_C.PRODUCT_NAMEU,TB_A.WAREHOUSE_QUANTITYU, SYSDATE AS STORAGE_TIMEU, SYSDATE CREATE_TIME, SYSDATE UPDATE_TIMEU, SYS_GUID() ROW_VERSIONU
FROM BI_MATCH_PALLET_DETAILU TB_A
inner join BI_MATCH_PALLETU TB_B ON TB_B.MATCH_PALLET_CODEU = TB_A.MATCH_PALLET_CODEU 
INNER JOIN BI_PRODUCTU TB_C ON TB_C.PRODUCT_CODEU = TB_A.PRODUCT_CODEU
WHERE TB_A.MATCH_PALLET_CODEU='HQQMG-1002';
*/
/*
----////根据配盘信息查找所有货位
SELECT * FROM WM_STORAGEU WHERE PRODUCT_CODEU IN (SELECT PRODUCT_CODEU FROM BI_MATCH_PALLET_DETAILU WHERE MATCH_PALLET_CODEU IN (
  SELECT MATCH_PALLET_CODEU FROM BI_MATCH_PALLETU WHERE MATCH_PALLET_NAMEU LIKE '%天行健%'));
--*/
--/*
CREATE OR REPLACE PROCEDURE p_location 
(V_LOCATION_CODEU VARCHAR2)
IS
  CURSOR location_cursor(v_location_code varchar2) IS    
    SELECT * FROM WM_LOCATIONU WHERE LOCATION_CODEU=v_location_code;
  CURSOR pallet_cursor(v_location_code varchar2) IS
    SELECT * FROM WM_PALLETU WHERE LOCATION_CODEU = v_location_code;
  CURSOR storage_cursor(v_location_code varchar2) IS
    select TB_STORAGE.LOCATION_CODEU, TB_STORAGE.STORAGE_QUANTITYU, TB_PALLET.STORAGE_SEQUENCEU 
    ,TB_PALLET.MATCH_PALLET_NAMEU, TB_STORAGE.PRODUCT_NAMEU, TB_PRODUCT.UNIT_NAMEU, TB_PRODUCT.TRANSFER_RATEU
    , TB_PRODUCT_DEFAULT.UNIT_NAMEU UNIT_NAMEU_DEFAULT, TB_PRODUCT_DEFAULT.TRANSFER_RATEU TRANSFER_RATEU_DEFAULT
    from WM_STORAGEU TB_STORAGE INNER JOIN WM_PALLETU TB_PALLET ON TB_STORAGE.PALLET_IDU = TB_PALLET.IDU
    INNER JOIN BI_PRODUCT_UNITU TB_PRODUCT_DEFAULT ON TB_PRODUCT_DEFAULT.PRODUCT_CODEU = TB_STORAGE.PRODUCT_CODEU AND TB_PRODUCT_DEFAULT.DEFAULT_UNITU='1'
    INNER JOIN BI_PRODUCT_UNITU TB_PRODUCT ON TB_PRODUCT.PRODUCT_CODEU = TB_STORAGE.PRODUCT_CODEU AND TB_PRODUCT.DEFAULT_UNITU='0'
    WHERE TB_STORAGE.LOCATION_CODEU = v_location_code
    --WHERE LENGTH(TB_STORAGE.LOCATION_CODEU)=6
    ORDER BY TB_STORAGE.LOCATION_CODEU,TB_PALLET.STORAGE_SEQUENCEU, TB_STORAGE.PRODUCT_NAMEU;
BEGIN  
  dbms_output.put_line('>>>>开始查找货位'||V_LOCATION_CODEU);
  dbms_output.put_line( RPAD('货位号', 15, ' ')|| RPAD('库存顺序' , 12, ' ')
    || RPAD('配盘名称', 15, ' ') || RPAD('产品名称', 30, ' ') || RPAD('库存数量', 15, ' ')
    || RPAD('转换率', 15, ' ')|| RPAD('多少(产品单位)->', 15, ' ')|| RPAD('产品单位', 15, ' ') 
    || RPAD('多少(默认产品单位)->', 20, ' ')|| RPAD('产品单位', 10, ' ') 
  );
  for storage_data in storage_cursor(V_LOCATION_CODEU)
  LOOP
    dbms_output.put_line(RPAD(storage_data.LOCATION_CODEU, 15, ' ')
      || RPAD(storage_data.STORAGE_SEQUENCEU , 10, ' ')|| RPAD(storage_data.MATCH_PALLET_NAMEU, 15, ' ')
      || RPAD(storage_data.PRODUCT_NAMEU, 35, ' ')
      || RPAD(storage_data.STORAGE_QUANTITYU, 15, ' ')
      || RPAD(storage_data.TRANSFER_RATEU, 15, ' ')
      || RPAD(storage_data.STORAGE_QUANTITYU/storage_data.TRANSFER_RATEU || RPAD(storage_data.UNIT_NAMEU, 25, ' '), 30, ' ')
      || RPAD(storage_data.STORAGE_QUANTITYU/storage_data.TRANSFER_RATEU_DEFAULT || RPAD(storage_data.UNIT_NAMEU_DEFAULT, 25, ' '), 30, ' ')
    );
  END LOOP;
  COMMIT;
END;
/
--/*
set serveroutput on;
begin
  p_location('01-09-01');
  p_location('03-28-01');
  commit;
end;
/
--*/



----查询不正常的盘位信息，是否有冻结数据？
--SELECT * FROM WM_PALLETU WHERE IN_FROZEN_QUANTITYU > 0 OR OUT_FROZEN_QUANTITYU > 0;

--UPDATE WM_LOCATIONU SET LOCATION_STATUSU = 0  WHERE LOCATION_CODEU LIKE '01-%';
--SELECT * FROM WM_LOCATIONU WHERE LOCATION_CODEU LIKE '01-01-01';
--/*
----查询01排满足条件的所有货位，找出货位上已经使用了1个还是2个盘位
----2020年4月1日09:23:13，看不懂了。。。2020年12月31日15:14:30，再看，这不是很明确吗，USED_ROW_NUM设置为多少，代表找出的货位就是使用了多少个盘位
SELECT * FROM (
    SELECT SUM(EXIST_ROWNUM) AS USED_ROW_NUM,LOCATION_CODEU  FROM (    
        SELECT CASE WHEN STORAGE_SEQUENCEU =1 OR STORAGE_SEQUENCEU=2 THEN 1
           ELSE 0 END AS EXIST_ROWNUM, LOCATION_CODEU FROM WM_PALLETU
        WHERE 1=1
        --AND LOCATION_CODEU LIKE '01-01-04%'
    )  
    GROUP BY LOCATION_CODEU
)
 WHERE 1=1
 AND USED_ROW_NUM =0
 order by USED_ROW_NUM,LOCATION_CODEU;
--*/