


----////////产品信息
SELECT * FROM BI_PRODUCT_UNITU WHERE PRODUCT_CODEU='150600002049';
SELECT * FROM BI_PRODUCTU WHERE PRODUCT_NAMEU LIKE '%防伪%';
SELECT UNIT_CODEU,TRANSFER_RATE FROM BI_PRODUCT_UNITU WHERE UNIT_TYPEU=1;

----产品单位换算，直接从配盘找得
  SELECT DISTINCT A1, A2, B1/B2, B11, 1, PRU01.UNIT_NAMEU B21
  FROM
    (SELECT A1, A2, B1, PRU.UNIT_NAMEU B11, B2, B21 
    FROM
    (SELECT MP.PRODUCT_CODEU A1, PR.PRODUCT_NAMEU A2, MP.WAREHOUSE_QUANTITYU/MP.WAREHOUSE_TRANSFER_RATEU B1, MP.WAREHOUSE_UNIT_CODEU B11
      , MP.WORKSHOP_QUANTITYU/MP.WORKSHOP_TRANSFER_RATEU B2, MP.WORKSHOP_UNIT_CODEU B21
      FROM BI_MATCH_PALLET_DETAILU MP
      inner join BI_PRODUCTU PR on PR.PRODUCT_CODEU = MP.PRODUCT_CODEU
      ) TB_1
      INNER JOIN BI_PRODUCT_UNITU PRU ON PRU.UNIT_CODEU = TB_1.B11) TB_2
      INNER JOIN BI_PRODUCT_UNITU PRU01 ON PRU01.UNIT_CODEU = TB_2.B21
      ORDER BY A2;
----如何对比出BI_PRODUCT_UNITU和BI_MATCH_PALLET_DETAILU的转换率是否都一致？？？
SELECT CASE WHEN WAREHOUSE_TRANSFER_RATEU != TRANSFER_RATEU  THEN 0 ELSE 1 END AS TRANSFER_RATEU, PRODUCT_CODEU
  FROM(SELECT PALLET_DETAIL.PRODUCT_CODEU, PALLET_DETAIL.WAREHOUSE_TRANSFER_RATEU, PRODUCT_UNIT.TRANSFER_RATEU
      FROM BI_MATCH_PALLET_DETAILU PALLET_DETAIL
      INNER JOIN BI_PRODUCT_UNITU PRODUCT_UNIT ON PRODUCT_UNIT.PRODUCT_CODEU = PALLET_DETAIL.PRODUCT_CODEU AND PRODUCT_UNIT.UNIT_TYPEU=1)
  ORDER BY TRANSFER_RATEU; --这只对比了仓库单位
SELECT CASE WHEN TRANSFER_RATEU01 != TRANSFER_RATEU  THEN 0 ELSE 1 END AS TRANSFER_RATEU, PRODUCT_CODEU
  FROM(SELECT PALLET_DETAIL.PRODUCT_CODEU, PALLET_DETAIL.WORKSHOP_TRANSFER_RATEU AS TRANSFER_RATEU01, PRODUCT_UNIT.TRANSFER_RATEU
      FROM BI_MATCH_PALLET_DETAILU PALLET_DETAIL
      INNER JOIN BI_PRODUCT_UNITU PRODUCT_UNIT ON PRODUCT_UNIT.PRODUCT_CODEU = PALLET_DETAIL.PRODUCT_CODEU AND PRODUCT_UNIT.UNIT_TYPEU=2)
  ORDER BY TRANSFER_RATEU;

----配盘管理
SELECT * FROM BI_MATCH_PALLETU WHERE BRAND_NAMESU LIKE '%新版银河%';
--UPDATE BI_MATCH_PALLETU SET ACTIVEU='0' WHERE LENGTH(MATCH_PALLET_CODEU) >LENGTH('HQQXBYH-2001');
SELECT * FROM BI_MATCH_PALLETU WHERE LENGTH(MATCH_PALLET_CODEU) >LENGTH('HQQXBYH-2001');
SELECT * FROM BI_MATCH_PALLET_DETAILU WHERE PRODUCT_CODEU='03050101000000056';
SELECT * FROM BI_MATCH_PALLET_DETAILU WHERE MATCH_PALLET_CODEU='HQQXBYH-1003';
SELECT * FROM BI_MATCH_PALLET_DETAILU
  WHERE MATCH_PALLET_CODEU IN
  (SELECT MATCH_PALLET_CODEU FROM BI_MATCH_PALLETU WHERE BRAND_CODESU='69010281617180001' AND MATCH_PALLET_CODEU LIKE '%1001%');

  
----不同牌号下产品，依据1、牌号；2、配盘排序号；3、产品排序号
SELECT * FROM 
--SELECT PRODUCT_CODEU, PRODUCT_NAMEU FROM 
  (
    SELECT TB_B.BRAND_CODESU, TB_B.BRAND_NAMESU, TB_B.PALLET_TYPE_NAMEU, TB_B.REMARKU, TB_A.PRODUCT_CODEU, TB_C.PRODUCT_NAMEU, TB_C.SORT_NOU
    , row_number() OVER (PARTITION BY TB_A.PRODUCT_CODEU ORDER BY TB_B.BRAND_CODESU) V_NUM  --如果order by字段是PRODUCT_CODEU，会导致只取一条的最终结果排序不按照牌号来
    FROM BI_MATCH_PALLET_DETAILU TB_A
    INNER JOIN BI_MATCH_PALLETU TB_B ON TB_B.MATCH_PALLET_CODEU = TB_A.MATCH_PALLET_CODEU
    INNER JOIN BI_PRODUCTU TB_C ON TB_C.PRODUCT_CODEU = TB_A.PRODUCT_CODEU
    --xXXXXXX   ORDER BY TB_B.REMARKU, TB_B.BRAND_CODESU, TB_C.SORT_NOU)
    ORDER BY TB_B.BRAND_CODESU, TB_B.REMARKU, TB_C.SORT_NOU)
    --ORDER BY TB_C.SORT_NOU, TB_B.REMARKU, TB_B.BRAND_CODESU )
  WHERE V_NUM = 1;--保证产品编码唯一



----查找库存中的厂商信息*************
----查找区域
SELECT * FROM WM_REGIONU;
----查找盘位、货位
SELECT * FROM WM_LOCATIONU WHERE LOCATION_CODEU LIKE '%w002r05%';
SELECT * FROM WM_LOCATIONU WHERE LOCATION_CODEU LIKE '%01-03-02%';
SELECT * FROM WM_LOCATIONU WHERE LOCATION_STATUSU='1'; --正常货位
SELECT * FROM WM_PALLETU;-- WHERE IDU='028C2BD57E43874A81A78816ACF030CB';
SELECT * FROM WM_PALLETU WHERE LOCATION_CODEU LIKE '%01-03-02%' OR LOCATION_CODEU ='01-19-01' ORDER BY LOCATION_CODEU;
SELECT * FROM WM_PALLETU WHERE STORAGE_QUANTITYU!=0 and MATCH_PALLET_NAMEU IS NULL;
SELECT * FROM WM_PALLETU WHERE PALLET_TYPE_NAMEU LIKE '%%' AND BRAND_NAMESU LIKE '%红旗渠（芒果）%';
SELECT * FROM WM_PALLETU WHERE LOCATION_CODEU LIKE '%01-01-02%';
SELECT * FROM WM_PALLETU WHERE IDU IN
(
SELECT DISTINCT PALLET_IDU FROM WM_STORAGEU WHERE FACTURER_CODEU NOT IN (SELECT BI_FACTURERU.FACTURER_CODEU FROM BI_FACTURERU)
);
SELECT TB_A.LOCATION_CODEU, TB_A.MATCH_PALLET_NAMEU, TB_B.STORAGE_TIMEU
  FROM WM_PALLETU TB_A INNER JOIN WM_STORAGEU TB_B ON TB_B.LOCATION_CODEU=TB_A.LOCATION_CODEU
  WHERE TB_A.BRAND_NAMESU LIKE '%硬帝豪%' AND TB_A.PALLET_TYPE_NAMEU LIKE '%通用包%' AND LENGTH(TB_A.LOCATION_CODEU)=8
  ORDER BY TB_B.STORAGE_TIMEU, TB_A.LOCATION_CODEU;
--下面是找出有机组退料仅占所在货位其中一盘的所有盘位
    SELECT TB_A_A.LOCATION_CODEU ,TB_A_A.STORAGE_SEQUENCEU,TB_A_B.BACK_MATERIAL_NUM, TB_A_B.IDENTITY_TAGU FROM WM_PALLETU TB_A_A INNER JOIN
      (SELECT TB_A.LOCATION_CODEU, COUNT(TB_A.LOCATION_CODEU) BACK_MATERIAL_NUM, TB_B.IDENTITY_TAGU FROM WM_PALLETU TB_A
        INNER JOIN (SELECT DISTINCT PALLET_IDU, LOCATION_CODEU,IDENTITY_TAGU FROM WM_STORAGEU WHERE IDENTITY_TAGU IS NOT NULL ORDER BY LOCATION_CODEU) TB_B ON TB_B.PALLET_IDU = TB_A.IDU
        GROUP BY TB_A.LOCATION_CODEU, TB_B.IDENTITY_TAGU 
      ) TB_A_B ON TB_A_B.LOCATION_CODEU=TB_A_A.LOCATION_CODEU
      WHERE TB_A_B.BACK_MATERIAL_NUM = 1 AND TB_A_A.STORAGE_QUANTITYU > 0;
----加上条件后，是找出现在还不能实现要料到退回班组、机组的物料。
    SELECT TB_A_A.LOCATION_CODEU ,TB_A_A.STORAGE_SEQUENCEU,TB_A_B.BACK_MATERIAL_NUM, TB_A_B.IDENTITY_TAGU FROM WM_PALLETU TB_A_A INNER JOIN
      (SELECT TB_A.LOCATION_CODEU, COUNT(TB_A.LOCATION_CODEU) BACK_MATERIAL_NUM, TB_B.IDENTITY_TAGU FROM WM_PALLETU TB_A
        INNER JOIN (SELECT DISTINCT PALLET_IDU, LOCATION_CODEU,IDENTITY_TAGU FROM WM_STORAGEU WHERE IDENTITY_TAGU IS NOT NULL ORDER BY LOCATION_CODEU) TB_B ON TB_B.PALLET_IDU = TB_A.IDU
        GROUP BY TB_A.LOCATION_CODEU, TB_B.IDENTITY_TAGU 
      ) TB_A_B ON TB_A_B.LOCATION_CODEU=TB_A_A.LOCATION_CODEU
      WHERE TB_A_B.BACK_MATERIAL_NUM = 1 AND TB_A_A.STORAGE_QUANTITYU > 0 AND TB_A_A.STORAGE_SEQUENCEU=2
      ORDER BY TB_A_A.LOCATION_CODEU;
----
SELECT * FROM 
  (SELECT COUNT(LOCATION_CODEU) OCCUPY__NUM, LOCATION_CODEU,STORAGE_SEQUENCEU,BACK_MATERIAL_NUM, IDENTITY_TAGU FROM 
    (--下面是找出有机组退料仅占所在货位其中一盘的所有盘位
    SELECT TB_A_A.LOCATION_CODEU ,TB_A_A.STORAGE_SEQUENCEU,TB_A_B.BACK_MATERIAL_NUM, TB_A_B.IDENTITY_TAGU FROM WM_PALLETU TB_A_A INNER JOIN
      (SELECT TB_A.LOCATION_CODEU, COUNT(TB_A.LOCATION_CODEU) BACK_MATERIAL_NUM, TB_B.IDENTITY_TAGU FROM WM_PALLETU TB_A
        INNER JOIN (SELECT DISTINCT PALLET_IDU, LOCATION_CODEU,IDENTITY_TAGU FROM WM_STORAGEU WHERE IDENTITY_TAGU IS NOT NULL ORDER BY LOCATION_CODEU) TB_B ON TB_B.PALLET_IDU = TB_A.IDU
        GROUP BY TB_A.LOCATION_CODEU, TB_B.IDENTITY_TAGU 
      ) TB_A_B ON TB_A_B.LOCATION_CODEU=TB_A_A.LOCATION_CODEU
      WHERE TB_A_B.BACK_MATERIAL_NUM = 1 AND TB_A_A.STORAGE_QUANTITYU > 0
    ) GROUP BY LOCATION_CODEU,STORAGE_SEQUENCEU,BACK_MATERIAL_NUM, IDENTITY_TAGU
  ) --WHERE OCCUPY__NUM !=2
    ORDER BY LOCATION_CODEU;
SELECT LOCATION_CODEU, COUNT(LOCATION_CODEU) LNUM FROM WM_PALLETU GROUP BY LOCATION_CODEU ORDER BY LOCATION_CODEU;
SELECT LOCATION_CODEU FROM WM_PALLETU GROUP BY LOCATION_CODEU ORDER BY LOCATION_CODEU;
SELECT DISTINCT PALLET_IDU, LOCATION_CODEU,IDENTITY_TAGU FROM WM_STORAGEU ORDER BY LOCATION_CODEU;
SELECT * FROM WM_STORAGEU WHERE IDENTITY_TAGU IS NOT NULL;
SELECT LOCATION_CODEU,STORAGE_QUANTITYU, IN_FROZEN_QUANTITYU, OUT_FROZEN_QUANTITYU, IDENTITY_TAGU FROM WM_STORAGEU WHERE LOCATION_CODEU IN (SELECT LOCATION_CODEU FROM WM_LOCATIONU WHERE LOCATION_STATUSU='1');
SELECT * FROM WM_STORAGEU WHERE PALLET_IDU IN
  (SELECT IDU FROM WM_PALLETU WHERE PALLET_TYPE_NAMEU LIKE '%%' AND BRAND_NAMESU LIKE '%红旗渠（芒果）%');
SELECT * FROM WM_STORAGEU WHERE PALLET_IDU IN
  (SELECT IDU FROM WM_PALLETU WHERE PALLET_TYPE_NAMEU LIKE '%商标%' AND BRAND_NAMESU LIKE '%新版银河%')
  AND LENGTH(LOCATION_CODEU)=8 AND STORAGE_TIMEU < TO_DATE('2020/11/25 08:43:55',  'yyyy-mm-dd hh24:mi:ss');
SELECT * FROM WM_STORAGEU WHERE FACTURER_NAMEU LIKE '%河南桐裕%'AND LENGTH(LOCATION_CODEU)=8;
SELECT * FROM WM_STORAGEU WHERE LOCATION_CODEU='101002';
SELECT * FROM WM_STORAGEU WHERE IDU='7CAA22CE01AF4C4F92939D5CAA64AF8E';
SELECT * FROM WM_STORAGEU WHERE PALLET_IDU IN
  (SELECT IDU FROM WM_PALLETU WHERE PALLET_TYPE_NAMEU LIKE '%%' AND BRAND_NAMESU LIKE '%红旗渠（芒果）%');
SELECT * FROM WM_STORAGEU WHERE FACTURER_NAMEU LIKE '%河南桐裕%'AND LENGTH(LOCATION_CODEU)=8;
SELECT * FROM WM_STORAGEU;-- WHERE IDU='7CAA22CE01AF4C4F92939D5CAA64AF8E';
----查找厂商时使用NOT IN时候，要注意值是否为null
SELECT * FROM BI_FACTURERU WHERE FACTURER_CODEU NOT IN
( 
  SELECT DISTINCT FACTURER_CODEU FROM WM_STORAGEU WHERE LENGTH(LOCATION_CODEU)=8 AND FACTURER_CODEU IS NOT NULL  --一定要考虑数值是否为null，不然得到的是错误的结果
);

----机组信息
SELECT * FROM WM_MACHINEU ORDER BY MACHINE_CLASSIFYU;
----盘位和厂商
SELECT * FROM WM_PALLETU WHERE LENGTH(LOCATION_CODEU)=8 ORDER BY UPDATE_TIMEU DESC;
SELECT DISTINCT FACTURER_CODEU, FACTURER_NAMEU, LOCATION_CODEU FROM WM_STORAGEU WHERE LENGTH(LOCATION_CODEU)=8 AND FACTURER_NAMEU LIKE '%新郑金芒果%';
SELECT * FROM BI_FACTURERU;
----

----////////机组呼叫，结单
SELECT * FROM WM_MACHINE_CALLU;-- WHERE IDU='A9CE6BC276A7BC408898B2278D507080';
SELECT * FROM WM_MACHINE_CALLU WHERE TASK_NOU='30512';
SELECT * FROM WM_MACHINE_CALLU WHERE MACHINE_NAMEU LIKE '3#装封箱%';
SELECT * FROM WM_MACHINE_CALLU WHERE IDU IN
  (SELECT MACHINE_CALL_IDU FROM WM_MACHINE_CALL_DETAILU WHERE PRODUCT_CODEU='03050101000000056')
  AND BRAND_NAMEU LIKE '%黄金叶%'
  ;
SELECT * FROM BI_MATCH_PALLET_DETAILU WHERE MATCH_PALLET_CODEU IN
  (SELECT WM_MACHINE_CALLU.MATCH_PALLET_CODEU FROM WM_MACHINE_CALLU WHERE IDU='14A68CD10484004E8DB1E6F24D99E615');
SELECT * FROM WM_MACHINE_CALLU WHERE PRODUCTION_PLAN_NOU='P202009110004' AND MACHINE_CODEU LIKE '%4%';
SELECT * FROM WM_MACHINE_CALLU WHERE PALLET_BARCODEU='03790263'  AND MACHINE_CODEU='B201';
SELECT * FROM WM_MACHINE_CALL_DETAILU 
  WHERE MACHINE_CALL_IDU IN (SELECT IDU FROM WM_MACHINE_CALLU WHERE TASK_NOU='7167') ORDER BY PRODUCT_CODEU;
SELECT * FROM WM_MACHINE_CALL_DETAILU 
  WHERE MACHINE_CALL_IDU IN (SELECT IDU FROM WM_MACHINE_CALLU WHERE WM_MACHINE_CALLU.BRAND_NAMEU LIKE '%硬帝豪%');
SELECT * FROM WM_MACHINE_CALL_DETAILU WHERE PRODUCT_CODEU='03050101000000056';
----余料退库4,移交退料5
SELECT * FROM WM_MACHINE_CALLU WHERE CALL_TYPEU=3 AND TASK_NOU='10319'; --03790263
----机组、机组盘位、机组托盘
SELECT * FROM WM_MACHINEU ORDER BY MACHINE_NAMEU;
update WM_MACHINEU set MACHINE_TYPEU=1;
SELECT * FROM WM_MACHINE_PALLETU WHERE WORK_POSITION_NOU='102005';202001
SELECT * FROM WM_MACHINE_PALLETU WHERE MACHINE_CODEU='B208';
SELECT * FROM WM_MACHINE_PALLETU WHERE  MACHINE_CODEU='B205' AND CURRENT_UNIQUE_IDU='03790762' AND ROWNUM=1;
SELECT PALLET_POSITIONU,MACHINE_CODEU FROM WM_MACHINE_PALLETU WHERE  MACHINE_CODEU='B205' AND CURRENT_UNIQUE_IDU='03790762' AND ROWNUM=1;
SELECT * FROM WM_MACHINE_PALLET_DETAILU;
SELECT * FROM WM_MACHINE_PALLET_DETAILU WHERE 
  MACHINE_CODEU=(SELECT MACHINE_CODEU FROM WM_MACHINE_PALLETU WHERE  MACHINE_CODEU='B208' AND CURRENT_UNIQUE_IDU='03790362' AND ROWNUM=1);
SELECT * FROM WM_MACHINE_PALLET_DETAILU WHERE 
  MACHINE_CODEU=(SELECT MACHINE_CODEU FROM WM_MACHINE_PALLETU WHERE  MACHINE_CODEU='B205' AND CURRENT_UNIQUE_IDU='03790762' AND ROWNUM=1)
  AND PALLET_POSITIONU=(SELECT PALLET_POSITIONU FROM WM_MACHINE_PALLETU WHERE  MACHINE_CODEU='B205' AND CURRENT_UNIQUE_IDU='03790762' AND ROWNUM=1);
-----查询机组移交
SELECT * FROM WM_MACHINE_HANDOVERU ORDER BY CREATE_TIMEU DESC;
SELECT * FROM WM_MACHINE_HANDOVER_DETAILU ORDER BY UPDATE_TIMEU DESC, TRANSFER_BILL_NOU;
SELECT * FROM WM_MACHINE_HANDOVERU WHERE TRANSFER_BILL_NOU='T202008180004' ORDER BY CREATE_TIMEU DESC;
SELECT * FROM WM_MACHINE_HANDOVERU WHERE CURRENT_PLANU='P202009300023' OR NEXT_PLANU='';
SELECT TB_A.TRANSFER_BILL_NOU, TB_A.MACHINE_NAMEU, TB_A.BRAND_NAMEU, TB_A.CURRENT_PLANU, TB_A.NEXT_PLANU, TO_CHAR(TB_A.TRANSFER_TIMEU, 'yy-mm-dd hh24:mi:ss'), TO_CHAR(TB_A.CREATE_TIMEU, 'yy-mm-dd hh24:mi:ss')
  --, TB_A.* 
  FROM WM_MACHINE_HANDOVERU TB_A WHERE CURRENT_PLANU = NEXT_PLANU AND TB_A.CREATE_TIMEU BETWEEN to_date('2020/12/02 10:00:00', 'yyyy-mm-dd hh24:mi:ss') AND to_date('2020/12/02 16:00:00', 'yyyy-mm-dd hh24:mi:ss') ORDER BY CREATE_TIMEU DESC, CURRENT_PLANU;
SELECT TB_A.TRANSFER_BILL_NOU, TB_A.MACHINE_NAMEU, TB_A.BRAND_NAMEU, TB_A.CURRENT_PLANU, TB_A.NEXT_PLANU, TO_CHAR(TB_A.TRANSFER_TIMEU, 'yy-mm-dd hh24:mi:ss'), TO_CHAR(TB_A.CREATE_TIMEU, 'yy-mm-dd hh24:mi:ss')
  FROM WM_MACHINE_HANDOVERU TB_A WHERE TRANSFER_BILL_NOU IN (SELECT TRANSFER_BILL_NOU FROM WM_MACHINE_HANDOVERU TB_A WHERE CURRENT_PLANU = NEXT_PLANU) ORDER BY CREATE_TIMEU DESC, CURRENT_PLANU;
SELECT * FROM WM_MACHINE_HANDOVERU WHERE CURRENT_PLANU='P202009110014' AND NEXT_PLANU='P202009110022';
SELECT * FROM WM_MACHINE_HANDOVERU WHERE TRANSFER_BILL_NOU='T202010190021' OR TRANSFER_BILL_NOU='T202010200012';
SELECT * FROM WM_MACHINE_HANDOVERU WHERE TRANSFER_TIMEU BETWEEN to_date('2020/11/27 3:00:00', 'yyyy-mm-dd hh24:mi:ss') AND to_date('2020/11/27 12:30:00', 'yyyy-mm-dd hh24:mi:ss')
  AND MACHINE_CODEU LIKE '%6%' ORDER BY CREATE_TIMEU DESC;
SELECT RECEIVE_QUANTITYU, TRANSFER_QUANTITYU, TRANSFER_RATEU, TRANSFER_BILL_NOU, TO_CHAR(CREATE_TIMEU, 'yy-mm-dd hh24:mi:ss')
  FROM WM_MACHINE_HANDOVER_DETAILU 
  WHERE RECEIVE_QUANTITYU != TRANSFER_QUANTITYU ORDER BY UPDATE_TIMEU DESC, TRANSFER_BILL_NOU;
SELECT * FROM WM_MACHINE_HANDOVERU
   WHERE CURRENT_PLANU='P202008120024' ORDER BY CREATE_TIMEU DESC;
SELECT * FROM WM_MACHINE_HANDOVER_DETAILU WHERE TRANSFER_BILL_NOU =
  (SELECT TRANSFER_BILL_NOU FROM WM_MACHINE_HANDOVERU WHERE CURRENT_PLANU='P202008120024' AND ROWNUM=1)
  ORDER BY UPDATE_TIMEU DESC, TRANSFER_BILL_NOU;
----查询机组退料
SELECT * FROM WM_MACHINE_RETURNU WHERE CURRENT_PLANU='P202009110004';
SELECT * FROM WM_MACHINE_RETURN_DETAILU WHERE RETURN_BILL_NOU IN
  (SELECT RETURN_BILL_NOU FROM WM_MACHINE_RETURNU WHERE CURRENT_PLANU='P202009110004');

SELECT * FROM WM_MACHINE_RETURN_DETAILU
  WHERE RETURN_BILL_NOU IN (SELECT RETURN_BILL_NOU FROM WM_MACHINE_RETURNU WHERE WM_MACHINE_RETURNU.BRAND_NAMEU LIKE '%硬帝豪%') AND PRODUCT_CODEU='03050101000000031';
------生产计划生产工单
SELECT * FROM WM_PRODUCTION_PLANU;
SELECT * FROM WM_PRODUCTION_PLANU WHERE PRODUCTION_PLAN_NOU IN (
  SELECT PRODUCTION_PLAN_NOU FROM WM_PRODUCTION_PLAN_DETAILU WHERE WM_PRODUCTION_PLAN_DETAILU.PRODUCTION_BEGIN_TIMEU IS NULL);
SELECT * FROM WM_PRODUCTION_PLANU WHERE PRODUCTION_PLAN_NOU='P202009030015';
SELECT * FROM WM_PRODUCTION_PLANU WHERE PLAN_BEGIN_TIMEU <= (TRUNC( SYSDATE, 'DD' )-2) order by PLAN_BEGIN_TIMEU DESC;
SELECT * FROM WM_PRODUCTION_PLANU WHERE WM_PRODUCTION_PLANU.AUDIT_TIMEU BETWEEN to_date('2020/09/1 0:00:00', 'yyyy-mm-dd hh24:mi:ss') AND to_date('2020/09/26 18:16:17', 'yyyy-mm-dd hh24:mi:ss')
  ORDER BY CREATE_TIMEU DESC;
SELECT * FROM 
  (SELECT TEAM_CODEU, TEAM_NAMEU, MACHINE_CODEU, MACHINE_NAMEU, BRAND_CODEU, BRAND_NAMEU, ORIGIN_WORK_NOU FROM WM_PRODUCTION_PLAN_DETAILU WHERE PRODUCTION_PLAN_NOU IN 
    (SELECT PRODUCTION_PLAN_NOU FROM WM_PRODUCTION_PLANU WHERE MAKE_TIMEU BETWEEN (TRUNC( SYSDATE, 'DD' )) AND (TRUNC( SYSDATE, 'DD' )+1) AND ORIGIN_PLAN_NOU IS NOT NULL)
  ) TB_MES WHERE TEAM_CODEU=1; ----准备用来把这些MES新下达的数据同步到原先未从MES直接下达对应的生产计划的，赵说不用，那就不管了，不然可能需要使用游标来同步，因为要有好几个标志位。
SELECT * FROM WM_PRODUCTION_PLAN_DETAILU WHERE PRODUCTION_PLAN_NOU IN ('P202009010006','P202009020024','P202009030018','P202009050001','P202009060001','P202009070020','P202009080020');
SELECT * FROM WM_PRODUCTION_PLAN_DETAILU WHERE PRODUCTION_PLAN_NOU='P202009030015';
SELECT * FROM WM_PRODUCTION_PLAN_DETAILU WHERE MACHINE_CODEU IN ('B203') ORDER BY CREATE_TIMEU DESC;
SELECT * FROM WM_PRODUCTION_PLAN_DETAILU
  WHERE PRODUCTION_PLAN_NOU IN (SELECT PRODUCTION_PLAN_NOU FROM WM_PRODUCTION_PLANU WHERE WM_PRODUCTION_PLANU.AUDIT_TIMEU 
  BETWEEN to_date('2020/7/7 0:00:00', 'yyyy-mm-dd hh24:mi:ss') AND to_date('2020/7/8 0:00:00', 'yyyy-mm-dd hh24:mi:ss'))
  --AND TEAM_CODEU LIKE '%1%'
  --AND (MACHINE_CODEU LIKE '%06%')
  --AND BRAND_NAMEU LIKE '%芒果%'
  ORDER BY CREATE_TIMEU DESC, MACHINE_NAMEU;
-----//////////////


----////测试机组呼叫Test
SELECT * FROM WM_PALLETU WHERE LOCATION_CODEU LIKE '%01-06-03%';
SELECT * FROM WM_PALLETU WHERE LOCATION_CODEU='101002' OR LOCATION_CODEU LIKE '%04-25-01%';
SELECT * FROM WM_STORAGEU WHERE LOCATION_CODEU='101002' OR LOCATION_CODEU='04-30-02'
  ORDER BY PALLET_IDU;
SELECT * FROM WM_STORAGEU WHERE LOCATION_CODEU='101002';
UPDATE WM_STORAGEU SET STORAGE_QUANTITYU=IN_FROZEN_QUANTITYU WHERE LOCATION_CODEU='101002';
SELECT * FROM WM_MACHINE_CALLU;
SELECT * FROM WM_MACHINE_PALLETU;
SELECT * FROM WM_MACHINE_PALLET_DETAILU;
----////

----/////单据
----查找经常用到的表单的总行数
SELECT COUNT(*) ROWNUM_WM_IN_BILLU FROM WM_IN_BILLU;
SELECT COUNT(*) ROWNUM_WM_OUT_BILL_ALLOTU FROM WM_OUT_BILL_ALLOTU;
SELECT COUNT(*) ROWNUM_WM_IN_BILL_ALLOTU FROM WM_IN_BILL_ALLOTU;
SELECT COUNT(*) ROWNUM_TM_TASKU FROM TM_TASKU;
SELECT COUNT(*) ROWNUM_WM_ASSORTED_BILLU FROM WM_ASSORTED_BILLU;
----拼盘单据
SELECT * FROM WM_ASSORTED_BILLU;
SELECT * FROM WM_ASSORTED_BILL_DETAILU ORDER BY CREATE_TIMEU DESC;
SELECT * FROM WM_ASSORTED_BILL_DETAILU 
  WHERE ASSORTED_BILL_NOU IN
  (SELECT ASSORTED_BILL_NOU FROM WM_ASSORTED_BILLU WHERE WM_ASSORTED_BILLU.BRAND_NAMESU LIKE '%新版银河%' AND WM_ASSORTED_BILLU.PALLET_TYPE_NAMEU LIKE '%卷接盘%')
  ORDER BY CREATE_TIMEU DESC;
----入库单据、出库单据、出入库单据
SELECT * FROM WM_IN_BILLU ORDER BY CREATE_TIMEU DESC;
SELECT * FROM WM_IN_BILLU WHERE IN_BILL_STATUSU=5 ORDER BY CREATE_TIMEU DESC;
SELECT * FROM WM_IN_BILL_ALLOTU;-- WHERE LOCATION_CODEU='02-23-01' ORDER BY CREATE_TIMEU DESC;
SELECT * FROM WM_OUT_BILLU WHERE OUT_BILL_NOU ='O201912220001';
SELECT * FROM WM_OUT_BILL_ALLOTU WHERE CREATE_TIMEU BETWEEN to_date('2020/08/15 6:30:00', 'yyyy-mm-dd hh24:mi:ss') AND to_date('2020/08/16 6:30:00', 'yyyy-mm-dd hh24:mi:ss');

SELECT * FROM WM_OUT_BILLU WHERE OUT_BILL_STATUSU='5' ORDER BY MAKE_TIMEU DESC;
SELECT * FROM WM_OUT_BILLU WHERE OUT_BILL_STATUSU!='5' ORDER BY MAKE_TIMEU DESC;
-----update WM_OUT_BILLU SET OUT_BILL_STATUSU='5';
SELECT * FROM WM_OUT_BILL_ALLOTU WHERE LOCATION_CODEU='02-30-01' ORDER BY CREATE_TIMEU DESC;
SELECT * FROM WM_OUT_BILLU ;
----领退料单据人领人退
SELECT * FROM WM_MANUAL_MATERIAL_BILLU ORDER BY CREATE_TIMEU DESC;
SELECT * FROM WM_MANUAL_MATERIAL_BILL_DETAILU;
SELECT * FROM WM_MANUAL_MATERIAL_BILL_DETAILU WHERE PRODUCTION_PLAN_NOU='P202010050015';
SELECT * FROM WM_MANUAL_MATERIAL_BILL_DETAILU WHERE MANUAL_MATERIAL_BILL_NOU IN (
  SELECT MANUAL_MATERIAL_BILL_NOU FROM WM_MANUAL_MATERIAL_BILLU WHERE AUDITORU LIKE '%张红伟%');
SELECT * FROM WM_MANUAL_MATERIAL_BILL_DETAILU WHERE PRODUCTION_PLAN_NOU IN
  (
  SELECT PRODUCTION_PLAN_NOU FROM WM_PRODUCTION_PLAN_DETAILU
    WHERE PRODUCTION_PLAN_NOU IN (SELECT PRODUCTION_PLAN_NOU FROM WM_PRODUCTION_PLANU WHERE WM_PRODUCTION_PLANU.AUDIT_TIMEU 
    BETWEEN to_date('2020/10/14 0:00:00', 'yyyy-mm-dd hh24:mi:ss') AND to_date('2020/10/15 0:00:00', 'yyyy-mm-dd hh24:mi:ss'))
    AND TEAM_CODEU LIKE '%1%'
    AND MACHINE_CODEU LIKE '%06%'
    --AND BRAND_NAMEU LIKE '%芒果%'
    );
----盘点单据
SELECT * FROM WM_INVENTORY_BILL_DETAILU WHERE INVENTORY_BILL_NOU='I202012220011';
SELECT * FROM WM_INVENTORY_BILLU;
----日结单据
SELECT * FROM WM_DAILY_BALANCE_BILLU ORDER BY PRODUCT_CODEU, REGION_CODEU;
SELECT TO_CHAR(TB_A.SETTLE_DATEU, 'yy-mm-dd hh24:mi:ss'), TB_A.* FROM WM_DAILY_BALANCE_BILLU TB_A WHERE (ENTRY_QUANTITYU > 0) OR (OUT_QUANTITYU > 0) OR (PROFIT_QUANTITYU > 0) OR (LOSS_QUANTITYU > 0)
  ORDER BY PRODUCT_CODEU, REGION_CODEU;
SELECT * FROM WM_DAILY_BALANCE_BILL_HISTORYU;
----月结信息
SELECT * FROM WM_MONTHLY_BALANCEU;
SELECT TO_CHAR(TB_A.SETTLE_DATEU, 'yy-mm-dd hh24:mi:ss'), TB_A.* FROM WM_MONTHLY_BALANCEU TB_A;
--UPDATE WM_MONTHLY_BALANCEU SET BALANCE_QUANTITYU=0;
----/////////

----/********盘点作业涉及表，测试盘点
SELECT TB_A.*, TB_A.LOCK_TAGU FROM WM_STORAGEU TB_A WHERE LOCATION_CODEU='01-01-02' ORDER BY PALLET_IDU DESC, PRODUCT_CODEU;
SELECT TB_A.STORAGE_QUANTITYU, TB_A.LOCK_TAGU FROM WM_STORAGEU TB_A WHERE LOCATION_CODEU='01-01-02' ORDER BY PALLET_IDU DESC, PRODUCT_CODEU;
SELECT TB_A.* FROM WM_PALLETU TB_A WHERE LOCATION_CODEU='01-01-02';
----盘点单据
SELECT * FROM WM_INVENTORY_BILLU;
SELECT * FROM WM_INVENTORY_BILL_HISTORYU;
SELECT * FROM WM_INVENTORY_BILL_DETAILU;
SELECT * FROM WM_INVENTORY_BILL_DETAIL_HISTORYU;
--UPDATE WM_INVENTORY_BILL_DETAILU SET INVENTORY_BILL_DETAIL_STATUSU=2 WHERE RECORD_UNIQUE_IDU='03790423';
SELECT * FROM "C##FUSION"."WM_INVENTORY_BILLU";
SELECT * FROM TM_TASKU;
SELECT * FROM TM_TASK_DETAILU WHERE TASK_IDU IN (SELECT IDU FROM TM_TASKU WHERE TASK_NOU=3);
UPDATE TM_TASK_DETAILU SET BILL_TYPEU='3' WHERE TASK_IDU IN (SELECT IDU FROM TM_TASKU WHERE TASK_NOU=3);
----盘点结单后，损益单据的变化
SELECT * FROM WM_PROFIT_LOSS_BILL_DETAILU;

----/////有关设备的
----查找设备相关信息表
SELECT COUNT(TB_A.IDU) FROM EM_EQUIPMENT_TASKU TB_A;
SELECT * FROM EM_EQUIPMENT_TASKU TB_A;
SELECT * FROM TM_OPERATION_EQUIPMENTU;
SELECT * FROM TM_WORK_EQUIPMENTU;
----设备状态
SELECT * FROM EM_EQUIPMENT_STATUSU WHERE EQUIPMENT_STATUS_CODEU='4';
SELECT * FROM EM_EQUIPMENT_ALARMU WHERE ALARM_CODEU LIKE '%CR%' ORDER BY ALARM_CODEU;

----任务信息
SELECT COUNT(*) FROM TM_TASKU;
SELECT * FROM TM_TASKU WHERE IDU IN
  (SELECT TASK_IDU FROM TM_TASK_DETAILU WHERE BILL_TYPEU=2);
SELECT * FROM TM_TASK_DETAILU WHERE BILL_TYPEU=5;
SELECT * FROM TM_TASKU WHERE TASK_NOU='42758';
SELECT * FROM TM_TASKU WHERE ORIGIN_LOCATION_CODEU='01-14-03' ORDER BY CREATE_TIMEU DESC;
SELECT TASK_NOU, RFIDU,CREATE_TIMEU FROM TM_TASKU WHERE RFIDU LIKE '%0710%' ORDER BY CREATE_TIMEU DESC; --由托盘条码找到任务号
SELECT * FROM TM_TASK_HISTORYU WHERE TASK_NOU='27239';
----作业位置
SELECT * FROM TM_WORK_POSITIONU WHERE WORK_POSITION_NOU LIKE '%2101%';
----数据监控数据交互信息交互查询数据
SELECT * FROM DMT_TAGU WHERE TAG_CODEU LIKE '%StorageInfoFeedback%';
SELECT * FROM DMT_INTERACTIVE_DATAU;
SELECT TO_CHAR(TB_A.CREATE_TIMEU, 'yy-mm-dd hh24:mi:ss'), TO_CHAR(TB_A.UPDATE_TIMEU, 'yy-mm-dd hh24:mi:ss'),
  TB_A.* FROM DMT_INTERACTIVE_DATAU TB_A 
  WHERE FEEDBACK_DATAU LIKE '%27043%'
  ORDER BY CREATE_TIMEU DESC;
SELECT * FROM DMT_INTERACTIVE_DATAU WHERE FEEDBACK_DATAU LIKE '%2107%' AND FEEDBACK_DATAU LIKE '%0130%'; --给的反馈经过2107
SELECT * FROM DMT_INTERACTIVE_DATAU WHERE CODEU LIKE '%412565%';
SELECT * FROM DMT_INTERACTIVE_DATAU WHERE CODEU LIKE '%412567%';
SELECT * FROM DMT_INTERACTIVE_DATAU WHERE REQUEST_DATAU LIKE '%任务号[42755]%' AND FIELDU = 131; ----131,盘点回库
SELECT * FROM DMT_INTERACTIVE_DATAU WHERE FEEDBACK_DATAU LIKE '%42758%' AND FIELDU = 131; ----131,盘点回库
SELECT * FROM DMT_INTERACTIVE_DATAU WHERE CODEU='438724';
SELECT * FROM DMT_INTERACTIVE_DATAU WHERE FIELDU = 131 ORDER BY CREATE_TIMEU DESC;
SELECT * FROM DMT_INTERACTIVE_MESSAGEU;


----//其他设置
----查询用户
SELECT * FROM SYS_USERU;
----数据词典
SELECT * FROM SYS_DICTIONARYU;
SELECT * FROM SYS_DICTIONARYU WHERE DICTIONARY_NAMEU LIKE '%单据%' ORDER BY DICTIONARY_GROUP_IDU;
SELECT * FROM SYS_DICTIONARYU WHERE IDU='8B6ACF77993F5141940FBA65861E3B5A' ORDER BY DICTIONARY_GROUP_IDU;
SELECT * FROM SYS_DICTIONARY_DETAILU where DICTIONARY_IDU IN (SELECT IDU FROM SYS_DICTIONARYU WHERE DICTIONARY_NAMEU LIKE '%单据类型%' ) ORDER BY VALUEU;
SELECT * FROM SYS_DICTIONARY_DETAILU where DICTIONARY_IDU IN (SELECT IDU FROM SYS_DICTIONARYU WHERE DICTIONARY_KEYU LIKE '%JobStatus%' ) ORDER BY VALUEU;

SELECT PARAMETER_VALUE_TYPEU FROM SYS_PARAMETERU;

----参数设置
SELECT * FROM SYS_PARAMETERU WHERE NAMEU LIKE '%IsEm%';
-----update SYS_PARAMETERU set PARAMETER_VALUE_TYPEU='0', DICTIONARY_KEYU='';

---区域和功能设置
SELECT * FROM SYS_AREAU;-- WHERE NAMEU LIKE '%库存%';
SELECT * FROM SYS_MODULEU WHERE NAMEU LIKE '%产品%' OR NAMEU LIKE '%预警%';
SELECT TB_A.NAMEU AS MODULE_NAME, TB_B.NAMEU AS AREA_NAME, TB_A.* FROM SYS_MODULEU TB_A INNER JOIN SYS_AREAU TB_B ON TB_A.AREAU = TB_B.AREA_NAMEU
  WHERE TB_A.NAMEU LIKE '%产品%' OR TB_A.NAMEU LIKE '%预警%';
SELECT * FROM SYS_FUNCTIONU;


----日志信息
SELECT * FROM SYS_USER_OPERATION_LOGU WHERE OPERATION_DESCRIPTIONU LIKE '%03-10-02%';
SELECT * FROM SYS_USER_OPERATION_LOGU WHERE OPERATION_DESCRIPTIONU LIKE '%M202005090003%';
SELECT * FROM SYS_USER_OPERATION_LOGU WHERE CONTROLLER_NAMEU LIKE '%PalletPositionUnlock%' ORDER BY OPERATION_TIMEU DESC;
SELECT * FROM SYS_USER_OPERATION_LOGU WHERE CONTROLLER_NAMEU LIKE '%PalletPositionUnlock%' AND OPERATION_DESCRIPTIONU LIKE '%03-10-02%';
SELECT * FROM SYS_USER_OPERATION_LOGU WHERE CONTROLLER_NAMEU LIKE '%PalletPositionUnlock%' AND OPERATION_DESCRIPTIONU LIKE '%02-03-01%';
SELECT * FROM SYS_RUNNING_LOGU;
SELECT * FROM SYS_DATABASE_OPERATION_LOGU;
