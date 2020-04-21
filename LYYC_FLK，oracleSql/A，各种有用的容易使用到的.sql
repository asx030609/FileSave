/* 基本的
select ('K'||to_char(sysdate,'yyyyMMdd')) k_name from sys_useru;
select ('Y'||lpad(IDU, 35, '0')) START_CODE from sys_useru; 
--SELECT ('K'||lpad(NVL(MAX(to_number(REPLACE( '2K32'?,? 'K'?,''))),0)+ 1,5,'0'));
SELECT LENGTH('123456') FROM DUAL;
--*/
----在输入时候就可以输入替换符，查找这个表单的非空列信息       
SELECT COLUMN_NAME, NUM_DISTINCT, LOW_VALUE, HIGH_VALUE, DENSITY , NUM_NULLS , AVG_COL_LEN , HISTOGRAM, NUM_BUCKETS  FROM DBA_TAB_COL_STATISTICS WHERE TABLE_NAME = '&TABLE_NAME' AND LOW_VALUE IS NOT NULL;

--查询映射后，除表MigrationHistory的表总数
--select table_name from dba_tables where tablespace_name = 'USERS' and table_name != 'MigrationHistory' order by table_name;
----查询一条未存放货物的盘位
SELECT * FROM (SELECT * FROM WM_PALLETU WHERE IDU NOT IN (SELECT PALLET_IDU FROM WM_STORAGEU) AND LENGTH(LOCATION_CODEU)=8 ORDER BY LOCATION_CODEU DESC) WHERE ROWNUM=1;

---同时更新某数据表的几列
  update "C##FUSION"."WM_PALLETU"
set ("PRODUCT_COUNTU", "IN_FROZEN_QUANTITYU" , "UPDATE_TIMEU" , "ROW_VERSIONU" )
=
  (SELECT '2' , '2' , SYSDATE ,  SYS_GUID() FROM DUAL)
where ((("IDU" =  SYS_GUID()) and ("LOCATION_CODEU" =  '99-99-99' )));

----SUM、count函数应用在inner join中
SELECT SUM(TB_A.WAREHOUSE_QUANTITYU) OVER (PARTITION  by TB_A.MATCH_PALLET_CODEU) AS STORAGE_QUANTITYU, TB_B.MATCH_PALLET_CODEU, count(*) OVER (PARTITION  by TB_A.MATCH_PALLET_CODEU)
FROM BI_MATCH_PALLET_DETAILU TB_A
inner join BI_MATCH_PALLETU TB_B ON TB_B.MATCH_PALLET_CODEU = TB_A.MATCH_PALLET_CODEU WHERE TB_A.MATCH_PALLET_CODEU='HQQMG-1002' ORDER BY TB_A.MATCH_PALLET_CODEU DESC;

----INNER JOIN的ON有好几个条件，用AND连接
SELECT * FROM WM_MACHINE_PALLET_DETAILU TB_A
INNER JOIN WM_MACHINE_PALLETU TB_B ON TB_B.MACHINE_CODEU = TB_A.MACHINE_CODEU and TB_A.PALLET_POSITIONU = TB_B.PALLET_POSITIONU;

----查找库存中还没使用的产品编码，发现理解的妙用
SELECT * FROM BI_PRODUCTU TB_A
  LEFT JOIN WM_STORAGEU TB_B ON TB_B.PRODUCT_CODEU = TB_A.PRODUCT_CODEU
  WHERE TB_B.PRODUCT_CODEU IS NULL;
/*
----用户删除不了，可使用下面数据
  SELECT SID,SERIAL# FROM V$SESSION WHERE USERNAME='C##FUSION';
  alter system kill session '869,38813';
*/


 
 
/*
----oracle中如何转换时间？
SELECT TO_CHAR(SYSDATE, 'yy-mm-dd hh24:mi:ss') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'yymmddhh24miss') FROM DUAL;
SELECT to_date('2019/11/14 16:30:00', 'yyyy-mm-dd hh24:mi:ss') FROM DUAL;
--*/


--/*
----查看某表的主外键
----主要是通过user_Constraints的Constraint_Name = user_Constraints的R_CONSTRAINT_NAME
----好像有点反方向
SELECT
	a.OWNER AS 外键引用表拥有者,
	a.Table_Name AS 外键引用表,
	c.Column_Name AS 外键引用表的列,
	b.OWNER AS 外键被引用表拥有者,
	b.Table_Name AS 外键被引用表,
	d.Column_Name AS 外键被引用表的列,
	c.Constraint_Name AS 外键引用表约束名,
	d.Constraint_Name AS 外键被引用表约束名 
FROM
	user_Constraints a,
	user_Constraints b,
	user_Cons_Columns c,
	user_Cons_Columns d
WHERE
	a.r_Constraint_Name = b.Constraint_Name 
	AND a.Constraint_Type = 'R' --这个相关的表的列引用另外以列的
	AND b.Constraint_Type = 'P' --这个相关的表的列是被引用的
	AND a.r_Owner = b.OWNER 
	AND a.Constraint_Name = c.Constraint_Name 
	AND b.Constraint_Name = d.Constraint_Name 
	AND a.OWNER = c.OWNER 
	AND a.Table_Name = c.Table_Name 
	AND b.OWNER = d.OWNER 
	AND b.Table_Name = d.Table_Name
  AND a.Table_Name LIKE '%BI_PRODUCT_UNITU%'
  --AND (c.Column_Name LIKE '%REGION_DAILY_BALANCE_IDU%' or c.Column_Name LIKE '%WAREHOUSE_DAILY_BALANCE_IDU%')  --主键列
  --AND c.CONSTRAINT_NAME LIKE 'FK_WM_REGION_DAILY__%' --外键名
	order by a.Table_Name asc;
--*/

/*禁用主外键，以便更新主键引用表中的列    ---------->>>>>>好像没必要禁用，直接就可以更改了
select 'alter table '||'BI_PRODUCT_UNITU'||' disable constraint '||'FK_BI_PRODUCT_UNITU_1434066075'||';' from user_constraints where constraint_type='R'; 
alter table BI_PRODUCT_UNITU disable constraint FK_BI_PRODUCT_UNITU_1434066075;
UPDATE BI_PRODUCT_UNITU SET PRODUCT_CODEU='TEST_TEST' WHERE PRODUCT_CODEU='P0003'; ----只能更新主键引用表，被引用表的CODE不能更改
----select 'alter table '||'BI_PRODUCTU'||' disable constraint '||'PK_BI_PRODUCTU'||';' from user_constraints where constraint_type='P' AND ROWNUM=1;  
----alter table BI_PRODUCTU disable constraint PK_BI_PRODUCTU; ----ERROR：SQL 错误: ORA-02297: 无法禁用约束条件 (C##FUSION.PK_BI_PRODUCTU) - 存在相关性
--*/

/*
----查询某表的所有索引
SELECT 
 b.uniqueness, a.index_name, a.table_name, a.column_name
FROM all_ind_columns a, all_indexes b
where a.index_name = b.index_name 
    --or a.index_name like '%PK_EM_EQUIPMENT_TASKU%'
    and a.table_name like upper('%WM_MACHINE_CALLU%') -- in (upper('EM_EQUIPMENT_TASKU'), upper('EM_SUB_EQUIPMENTU'))
ORDER BY a.table_name, a.index_name, a.column_position;
--*/
------查询数据库的table
--select * from tab;
--select * from cat;
--select TABLE_NAME FROM user_tables;

---- 查找数据库所有表的字段信息
SELECT * FROM SYS.ALL_TAB_COLS WHERE "OWNER" = 'C##FUSION';-- AND TABLE_NAME LIKE '%BI_PRODUCT_SIZE%';
SELECT * FROM SYS.ALL_TAB_COLUMNS WHERE TABLE_NAME LIKE '%BI_PRODUCT_SIZE%' AND "OWNER" = 'C##FUSION';


/*
----查询含某字段的所有表
select count(table_name) from
  user_tab_cols where column_name = 'CURRENT_TASK_COUNTU' and table_name like '%TM_WORK_EQUIPMENTU%';
  
--select * from USER_TABS;
SELECT * FROM USER_TAB_COLS WHERE TABLE_NAME LIKE '%Parameter%';
*/

/*
----》查看oracle中表的索引
----oracle中表的索引信息存在 user_indexes 和 user_ind_columns 两张表里面，
----其中，
----user_indexes 系统视图存放是索引的名称以及该索引是否是唯一索引等信息，
----user_ind_columns 统视图存放的是索引名称，对应的表和列等
 select i.index_name,
       i.index_type,
       i.table_owner,
       i.table_name,
       i.uniqueness,
       i.tablespace_name,
       c.column_name,
       c.column_position,
       c.column_length
from user_indexes i, user_ind_columns c
where i.index_name = c.index_name
  and i.table_name='WM_PRODUCT_DAILY_BALANCE_HISTORYU';
--*/

---- 删除数据库(用户) --> 
--drop user c##fusion cascade;
---- 创建表空间 -->
-- create tablespace casic_smart datafile 'e:\oracle\product\10.2.0\oradata\orcl\casic_smart.dbf' size 1000m;
---- 创建用户,并指定表空间 --> -- 有些是没有指定表空间的,不知是否可行,未尝试,保险起见还是按下面方式来 --> 
--create user c##fusion identified by admin123456COM default tablespace casic_smart quota 500m on users;
-- 授予权限 --> 
--grant all privileges to c##fusion ;

--学习如何使用oracle上有的sql命令。
--select tablespace_name,file_name from dba_data_files;
--select * from dba_tablespaces t;
--select b.file_name 物理文件名,b.tablespace_name 表空间,b.bytes/1024/1024 大小M,(b.bytes-sum(nvl(a.bytes,0)))/1024/1024 已使用M,substr((b.bytes-sum(nvl(a.bytes,0)))/(b.bytes)*100,1,5) 利用率 from
--dba_free_space a,dba_data_files b where a.file_id=b.file_id group by b.tablespace_name,b.file_name,b.bytes order by b.tablespace_name;
--select tablespace_name,file_name from dba_temp_files; --查询临时表空间
--use [Fusion_LuoYangFLK]
--delete from WM_WAREHOUSE;
--set serveroutput on;
--declare Guid_1 varchar2(100):= SYS_GUID();
--begin
-- dbms_output.put_line('hello world');
-- dbms_output.put_line(sysdate);
-- dbms_output.put_line(firstGuid);
--end;

--      Insert into C##FUSION.SYS_USERU (IDU,USER_NAMEU,PASSWORDU,NAMEU,ACTIVEU,DESCRIPTIONU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values (SYS_GUID(),v_Name,v_Name,null,1,null,sysdate,sysdate,SYS_GUID());


----创建临时表并使用
--create global temporary table transaction_temp_tb (IDU varchar(20) primary key, NAMEU varchar2(20)) on commit delete rows;
--/
--set serveroutput on;
--SET DEFINE OFF;
--DECLARE
--  m_ServerCode varchar2(20) := 'WCSServer';
--  TEMP_NAME varchar2(20) := 'TEMP_NAME11';
--  tempTBNum NumBER;
--BEGIN
--  select count(1) into tempTBNum from user_tables where table_name = upper('transaction_temp_tb') ;
--  if tempTBNum > 0 then
--    dbms_output.put_line('临时表有数量'||tempTBNum);
--    --select count(1) into tempTBNum from transaction_temp_tb;
--    --execute immediate 'drop table transaction_temp_tb' ;
--  --ELSE 
--    --execute immediate 'create global temporary table transaction_temp_tb (IDU varchar(20) primary key, NAMEU varchar2(20)) on commit preserve rows';
--    --execute immediate 'create table transaction_temp_tb (IDU varchar(20) primary key, NAMEU varchar2(20)) on commit preserve rows';
--  end if;
--  --execute immediate 'create global temporary table transaction_temp_tb (IDU varchar(20) primary key, NAMEU varchar2(20)) on commit delete rows';
--	--execute immediate 'insert into  transaction_temp_tb(IDU, NAMEU) values(''abc'',''test'')';
--  INSERT INTO  TRANSACTION_TEMP_TB(IDU, NAMEU) VALUES('ABC','TEST');
--  SELECT NAMEU INTO TEMP_NAME FROM transaction_temp_tb WHERE NAMEU = 'TEST';
--  --dbms_output.put_line(IDU);
--  --COMMIT WORK;
--  dbms_output.put_line(TEMP_NAME);
--  COMMIT WORK;
--END;
--/

----查询并利用临时表的值
--BEGIN
--for item IN (select * from TRANSACTION_TEMP_TB)
--LOOP
----处理省略
----XXXXXXXXXXXXXX
--  dbms_output.put_line('3223');
--END LOOP;
--END;
--/
--    drop table transaction_temp_t