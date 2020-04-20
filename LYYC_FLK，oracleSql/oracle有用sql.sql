
SELECT TO_CHAR(SYSDATE, 'yy-mm-dd hh24:mi:ss') FROM DUAL;

----1股脑的更新表的多个字段
/*
update wm_palletu SET(MATCH_PALLET_CODEU, MATCH_PALLET_NAMEU,UNIQUE_IDU,BRAND_CODESU,BRAND_NAMESU,PALLET_TYPE_CODEU,PALLET_TYPE_NAMEU
) =(select MATCH_PALLET_CODEU, MATCH_PALLET_NAMEU,UNIQUE_IDU,BRAND_CODESU,BRAND_NAMESU,PALLET_TYPE_CODEU,PALLET_TYPE_NAMEU
    from WM_PALLETU WHERE IDU='94CAAE7485C147A29A21EC63ACCD3BB5') where idu='FFF92FDEF2A7C44089B45014E17D16F5';
    */
/*
select ('K'||to_char(sysdate,'yyyyMMdd')) k_name from sys_useru;
select ('Y'||lpad(IDU, 35, '0')) START_CODE from sys_useru; 
--SELECT ('K'||lpad(NVL(MAX(to_number(REPLACE( '2K32'?,? 'K'?,''))),0)+ 1,5,'0'))
*/

--查询映射后，除表MigrationHistory的表总数
--select table_name from dba_tables where tablespace_name = 'USERS' and table_name != 'MigrationHistory' order by table_name;
/*
--查找某函数，存储过程是否存在
SELECT *  FROM (SELECT * FROM ALL_OBJECTS ) WHERE ROWNUM=1;

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