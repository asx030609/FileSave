/* ������
select ('K'||to_char(sysdate,'yyyyMMdd')) k_name from sys_useru;
select ('Y'||lpad(IDU, 35, '0')) START_CODE from sys_useru; 
--SELECT ('K'||lpad(NVL(MAX(to_number(REPLACE( '2K32'?,? 'K'?,''))),0)+ 1,5,'0'));
SELECT LENGTH('123456') FROM DUAL;
--*/
----������ʱ��Ϳ��������滻��������������ķǿ�����Ϣ       
SELECT COLUMN_NAME, NUM_DISTINCT, LOW_VALUE, HIGH_VALUE, DENSITY , NUM_NULLS , AVG_COL_LEN , HISTOGRAM, NUM_BUCKETS  FROM DBA_TAB_COL_STATISTICS WHERE TABLE_NAME = '&TABLE_NAME' AND LOW_VALUE IS NOT NULL;

--��ѯӳ��󣬳���MigrationHistory�ı�����
--select table_name from dba_tables where tablespace_name = 'USERS' and table_name != 'MigrationHistory' order by table_name;
----��ѯһ��δ��Ż������λ
SELECT * FROM (SELECT * FROM WM_PALLETU WHERE IDU NOT IN (SELECT PALLET_IDU FROM WM_STORAGEU) AND LENGTH(LOCATION_CODEU)=8 ORDER BY LOCATION_CODEU DESC) WHERE ROWNUM=1;

---ͬʱ����ĳ���ݱ�ļ���
  update "C##FUSION"."WM_PALLETU"
set ("PRODUCT_COUNTU", "IN_FROZEN_QUANTITYU" , "UPDATE_TIMEU" , "ROW_VERSIONU" )
=
  (SELECT '2' , '2' , SYSDATE ,  SYS_GUID() FROM DUAL)
where ((("IDU" =  SYS_GUID()) and ("LOCATION_CODEU" =  '99-99-99' )));

----SUM��count����Ӧ����inner join��
SELECT SUM(TB_A.WAREHOUSE_QUANTITYU) OVER (PARTITION  by TB_A.MATCH_PALLET_CODEU) AS STORAGE_QUANTITYU, TB_B.MATCH_PALLET_CODEU, count(*) OVER (PARTITION  by TB_A.MATCH_PALLET_CODEU)
FROM BI_MATCH_PALLET_DETAILU TB_A
inner join BI_MATCH_PALLETU TB_B ON TB_B.MATCH_PALLET_CODEU = TB_A.MATCH_PALLET_CODEU WHERE TB_A.MATCH_PALLET_CODEU='HQQMG-1002' ORDER BY TB_A.MATCH_PALLET_CODEU DESC;

----INNER JOIN��ON�кü�����������AND����
SELECT * FROM WM_MACHINE_PALLET_DETAILU TB_A
INNER JOIN WM_MACHINE_PALLETU TB_B ON TB_B.MACHINE_CODEU = TB_A.MACHINE_CODEU and TB_A.PALLET_POSITIONU = TB_B.PALLET_POSITIONU;

----���ҿ���л�ûʹ�õĲ�Ʒ���룬������������
SELECT * FROM BI_PRODUCTU TB_A
  LEFT JOIN WM_STORAGEU TB_B ON TB_B.PRODUCT_CODEU = TB_A.PRODUCT_CODEU
  WHERE TB_B.PRODUCT_CODEU IS NULL;
/*
----�û�ɾ�����ˣ���ʹ����������
  SELECT SID,SERIAL# FROM V$SESSION WHERE USERNAME='C##FUSION';
  alter system kill session '869,38813';
*/


 
 
/*
----oracle�����ת��ʱ�䣿
SELECT TO_CHAR(SYSDATE, 'yy-mm-dd hh24:mi:ss') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'yymmddhh24miss') FROM DUAL;
SELECT to_date('2019/11/14 16:30:00', 'yyyy-mm-dd hh24:mi:ss') FROM DUAL;
--*/


--/*
----�鿴ĳ��������
----��Ҫ��ͨ��user_Constraints��Constraint_Name = user_Constraints��R_CONSTRAINT_NAME
----�����е㷴����
SELECT
	a.OWNER AS ������ñ�ӵ����,
	a.Table_Name AS ������ñ�,
	c.Column_Name AS ������ñ����,
	b.OWNER AS ��������ñ�ӵ����,
	b.Table_Name AS ��������ñ�,
	d.Column_Name AS ��������ñ����,
	c.Constraint_Name AS ������ñ�Լ����,
	d.Constraint_Name AS ��������ñ�Լ���� 
FROM
	user_Constraints a,
	user_Constraints b,
	user_Cons_Columns c,
	user_Cons_Columns d
WHERE
	a.r_Constraint_Name = b.Constraint_Name 
	AND a.Constraint_Type = 'R' --�����صı���������������е�
	AND b.Constraint_Type = 'P' --�����صı�����Ǳ����õ�
	AND a.r_Owner = b.OWNER 
	AND a.Constraint_Name = c.Constraint_Name 
	AND b.Constraint_Name = d.Constraint_Name 
	AND a.OWNER = c.OWNER 
	AND a.Table_Name = c.Table_Name 
	AND b.OWNER = d.OWNER 
	AND b.Table_Name = d.Table_Name
  AND a.Table_Name LIKE '%BI_PRODUCT_UNITU%'
  --AND (c.Column_Name LIKE '%REGION_DAILY_BALANCE_IDU%' or c.Column_Name LIKE '%WAREHOUSE_DAILY_BALANCE_IDU%')  --������
  --AND c.CONSTRAINT_NAME LIKE 'FK_WM_REGION_DAILY__%' --�����
	order by a.Table_Name asc;
--*/

/*������������Ա�����������ñ��е���    ---------->>>>>>����û��Ҫ���ã�ֱ�ӾͿ��Ը�����
select 'alter table '||'BI_PRODUCT_UNITU'||' disable constraint '||'FK_BI_PRODUCT_UNITU_1434066075'||';' from user_constraints where constraint_type='R'; 
alter table BI_PRODUCT_UNITU disable constraint FK_BI_PRODUCT_UNITU_1434066075;
UPDATE BI_PRODUCT_UNITU SET PRODUCT_CODEU='TEST_TEST' WHERE PRODUCT_CODEU='P0003'; ----ֻ�ܸ����������ñ������ñ��CODE���ܸ���
----select 'alter table '||'BI_PRODUCTU'||' disable constraint '||'PK_BI_PRODUCTU'||';' from user_constraints where constraint_type='P' AND ROWNUM=1;  
----alter table BI_PRODUCTU disable constraint PK_BI_PRODUCTU; ----ERROR��SQL ����: ORA-02297: �޷�����Լ������ (C##FUSION.PK_BI_PRODUCTU) - ���������
--*/

/*
----��ѯĳ�����������
SELECT 
 b.uniqueness, a.index_name, a.table_name, a.column_name
FROM all_ind_columns a, all_indexes b
where a.index_name = b.index_name 
    --or a.index_name like '%PK_EM_EQUIPMENT_TASKU%'
    and a.table_name like upper('%WM_MACHINE_CALLU%') -- in (upper('EM_EQUIPMENT_TASKU'), upper('EM_SUB_EQUIPMENTU'))
ORDER BY a.table_name, a.index_name, a.column_position;
--*/
------��ѯ���ݿ��table
--select * from tab;
--select * from cat;
--select TABLE_NAME FROM user_tables;

---- �������ݿ����б���ֶ���Ϣ
SELECT * FROM SYS.ALL_TAB_COLS WHERE "OWNER" = 'C##FUSION';-- AND TABLE_NAME LIKE '%BI_PRODUCT_SIZE%';
SELECT * FROM SYS.ALL_TAB_COLUMNS WHERE TABLE_NAME LIKE '%BI_PRODUCT_SIZE%' AND "OWNER" = 'C##FUSION';


/*
----��ѯ��ĳ�ֶε����б�
select count(table_name) from
  user_tab_cols where column_name = 'CURRENT_TASK_COUNTU' and table_name like '%TM_WORK_EQUIPMENTU%';
  
--select * from USER_TABS;
SELECT * FROM USER_TAB_COLS WHERE TABLE_NAME LIKE '%Parameter%';
*/

/*
----���鿴oracle�б������
----oracle�б��������Ϣ���� user_indexes �� user_ind_columns ���ű����棬
----���У�
----user_indexes ϵͳ��ͼ����������������Լ��������Ƿ���Ψһ��������Ϣ��
----user_ind_columns ͳ��ͼ��ŵ����������ƣ���Ӧ�ı���е�
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

---- ɾ�����ݿ�(�û�) --> 
--drop user c##fusion cascade;
---- ������ռ� -->
-- create tablespace casic_smart datafile 'e:\oracle\product\10.2.0\oradata\orcl\casic_smart.dbf' size 1000m;
---- �����û�,��ָ����ռ� --> -- ��Щ��û��ָ����ռ��,��֪�Ƿ����,δ����,����������ǰ����淽ʽ�� --> 
--create user c##fusion identified by admin123456COM default tablespace casic_smart quota 500m on users;
-- ����Ȩ�� --> 
--grant all privileges to c##fusion ;

--ѧϰ���ʹ��oracle���е�sql���
--select tablespace_name,file_name from dba_data_files;
--select * from dba_tablespaces t;
--select b.file_name �����ļ���,b.tablespace_name ��ռ�,b.bytes/1024/1024 ��СM,(b.bytes-sum(nvl(a.bytes,0)))/1024/1024 ��ʹ��M,substr((b.bytes-sum(nvl(a.bytes,0)))/(b.bytes)*100,1,5) ������ from
--dba_free_space a,dba_data_files b where a.file_id=b.file_id group by b.tablespace_name,b.file_name,b.bytes order by b.tablespace_name;
--select tablespace_name,file_name from dba_temp_files; --��ѯ��ʱ��ռ�
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


----������ʱ��ʹ��
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
--    dbms_output.put_line('��ʱ��������'||tempTBNum);
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

----��ѯ��������ʱ���ֵ
--BEGIN
--for item IN (select * from TRANSACTION_TEMP_TB)
--LOOP
----����ʡ��
----XXXXXXXXXXXXXX
--  dbms_output.put_line('3223');
--END LOOP;
--END;
--/
--    drop table transaction_temp_t