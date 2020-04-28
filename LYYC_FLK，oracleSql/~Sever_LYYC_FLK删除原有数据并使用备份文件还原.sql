
--/*
--select * from dba_directories; --查找所有目录
--提示用户连接错误时，如下处理
  SELECT SID,SERIAL# FROM V$SESSION WHERE USERNAME='C##FUSION';
  
  alter system kill session '266,46764';
drop tablespace C##Fusion INCLUDING CONTENTS AND DATAFILES;
drop user C##Fusion cascade;
drop  directory C##Fusion;
--*/
--/*
create tablespace C##Fusion datafile 'D:\workspace\Data\Fusion\Fusion.dbf' size 256m autoextend on next 256m extent management local;
create user C##Fusion IDENTIFIED BY admin123456COM;
alter user C##Fusion default tablespace C##Fusion temporary tablespace temp;
create directory C##Fusion as 'D:\workspace\Data\Fusion';
grant create session,create table,unlimited tablespace to C##Fusion;
grant create user,drop user,alter user ,create any view , drop any view,exp_full_database,imp_full_database,dba,connect,resource,create session to C##Fusion;
grant read,write on directory C##Fusion to C##Fusion;

--备份
----exp C##Fusion/admin123456COM@172.30.20.57/orcl file=D:\Fusion20191124.dmp full=y 成功
--还原
----imp C##Fusion/admin123456COM@127.0.0.1/orcl file=d:\Fusion.dmp full=y 成功

--create directory mydata as 'D:\data\oracle\oradata\mydata';     --主要是给mydata/ly1.dmp文件授权，impdp才能正常运行
--grant read,write on directory mydata to C##Fusion;
--cmd下执行这个--注，最后不要分号；
--覆盖原有数据库(慎用)impdp C##Fusion/admin123456COM@orcl directory=C##Fusion dumpfile=ly2020.dmp 成功
--cmd下执行这个--注，最后不要分号；
--备份***--expdp C##Fusion/admin123456COM@orcl directory=C##Fusion dumpfile=ly2020.dmp 成功
----如果有两个用户的话，还需要加什么add-exists-action，new数据库：old数据库



--备份指定表
----create directory mydata as 'D:\data\oracle\oradata\mydata';  sql>select * from dba_directories;
--cmd中--expdp C##Fusion/admin123456COM directory=C##Fusion dumpfile=ly_tb_20191125.dmp [logfile=expdp.log] tables=(TM_WORK_POSITIONU,WM_MACHINE_PALLETU); 成功
--还原指定表
--cmd中--impdp C##Fusion/admin123456COM directory=C##Fusion dumpfile=ly_tb_20191125.dmp [logfile=expdp.log] tables=(TM_WORK_POSITIONU,WM_MACHINE_PALLETU); 成功