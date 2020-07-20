
--/*
--select * from dba_directories; --查找所有目录
--提示用户连接错误时，如下处理
  SELECT 'alter system kill session '''|| SID||','||SERIAL#||''';' FROM V$SESSION WHERE USERNAME='C##FUSION';
  --alter system kill session '143,42146';
  --alter system kill session '394,45115';
  
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



--在进行逻辑备份时，首先要确认数据库的字符集和操作系统的字符集是否一致，如果不一致则会报错ora-00091，具体设置方法如下： 
--SQL> select * from v$nls_parameters where parameter in ('NLS_LANGUAGE','NLS_TERRITORY','NLS_CHARACTERSET');
----。。。可以通过exp help=y或者imp help=y查看exp或imp的详细参数
----...有时候我们需要使用SYSDBA来执行EXP/IMP，如进行传输表空间的EXP/IMP，以及在9i下用SYS用户来执行EXP/IMP时，都需要使用SYSDBA才可。我们可以使用下面方式连入EXP/IMP： 
-- exp "'sys/sys as sysdba'" file=1.dmp tables=gototop.t rows=n 
--一、expdp/impdp和exp/imp的区别
--1、exp和imp是客户端工具程序，它们既可以在客户端使用，也可以在服务端使用。
--2、expdp和impdp是服务端的工具程序，他们只能在oracle服务端使用，不能在客户端使用。
--3、imp只适用于exp导出的文件，不适用于expdp导出文件；impdp只适用于expdp导出的文件，而不适用于exp导出文件。
--4、对于10g以上的服务器，使用exp通常不能导出0行数据的空表，而此时必须使用expdp导出。

-----》》》》》正在使用的备份还原数据库
--（正在使用）覆盖原有数据库(慎用)impdp C##Fusion/admin123456COM@orcl directory=C##Fusion dumpfile=ly2020.dmp (成功)
--（正在使用）备份***--expdp C##Fusion/admin123456COM@orcl directory=C##Fusion dumpfile=ly2020.dmp 成功








--后期使用的创建命令(能更好的弄清各自的关系)
/*
--select * from dba_directories; --查找所有目录
--提示用户连接错误时，如下处理
  SELECT SID,SERIAL# FROM V$SESSION WHERE USERNAME='C##FUSION';
  --alter system kill session '139,35852';
drop tablespace TbS_C##Fusion INCLUDING CONTENTS AND DATAFILES;
drop user C##Fusion cascade;
drop  directory Dir_C##Fusion;
--*/
/*
create tablespace TbS_C##Fusion datafile 'D:\workspace\Data\Fusion\Master\Fusion.dbf' size 256m autoextend on next 256m extent management local;
create user C##Fusion IDENTIFIED BY admin123456COM;
alter user C##Fusion default tablespace TbS_C##Fusion temporary tablespace temp;
create directory Dir_C##Fusion as 'D:\workspace\Data\Fusion';
grant create session,create table,unlimited tablespace to C##Fusion;
grant create user,drop user,alter user ,create any view , drop any view,exp_full_database,imp_full_database,dba,connect,resource,create session to C##Fusion;
grant read,write on directory Dir_C##Fusion to C##Fusion;
--*/

-----打算用如下来改进，前期准备同样要有
--cmd下执行这个--注，最后不要分号；
--覆盖原有数据库(慎用)impdp C##Fusion/admin123456COM@orcl directory=Dir_C##Fusion dumpfile=ly20200428001.dmp logfile=impdp20200429001.log (成功)
--cmd下执行这个--注，最后不要分号；
--备份***--expdp C##Fusion/admin123456COM@orcl directory=Dir_C##Fusion dumpfile=ly2020.dmp 成功
----如果有两个用户的话，还需要加什么add-exists-action，new数据库：old数据库
----////


----////备份还原指定表
--备份指定表
----create directory mydata as 'D:\data\oracle\oradata\mydata';  sql>select * from dba_directories;
--cmd中--expdp C##Fusion/admin123456COM directory=C##Fusion dumpfile=ly_tb_20200429.dmp logfile=expdp20200429.log tables=(DMT_TAGU); --(2020年4月29日10:25:42)出现错误：ORA-39166: Object C##FUSION.; was not found or could not be exported or imported.
--还原指定表
--cmd中--impdp C##Fusion/admin123456COM directory=C##Fusion dumpfile=ly_tb_20200429.dmp logfile=impdp.log tables=(DMT_TAGU); --2020-4-29 10:00:31出现错误ORA-39166: Object C##FUSION.; was not found or could not be exported or imported.

--导出指定表，最后不用加分号(正在使用)
--exp C##FUSION/admin123456COM@localhost/orcl file=D:\workspace\Data\Fusion\Fusion_tagu.dmp tables=(BI_UNITU,BI_PRODUCTU,BI_PRODUCT_BARCODEU,BI_PRODUCT_SIZEU,BI_PRODUCT_UNITU) log=D:\workspace\Data\Fusion\exp20200429.log (成功)
--导入指定表   IGNORE=Y忽略创建错误 (N)
--imp C##FUSION/admin123456COM@localhost/orcl file=D:\workspace\Data\Fusion\Fusion_tagu.dmp tables=(BI_UNITU,BI_PRODUCTU,BI_PRODUCT_BARCODEU,BI_PRODUCT_SIZEU,BI_PRODUCT_UNITU) log=D:\workspace\Data\Fusion\imp20200429.log DESTROY=Y IGNORE=Y （成功）


----////备份还原数据库
--备份
----exp C##Fusion/admin123456COM@172.30.20.57/orcl file=D:\workspace\Data\Fusion\Fusion20191124.dmp full=y 成功
----exp C##Fusion/admin123456COM@localhost/orcl file=D:\workspace\Data\Fusion\Fusion20200511001.dmp full=y 成功
--还原
----imp C##Fusion/admin123456COM@127.0.0.1/orcl file=D:\workspace\Data\Fusion\Fusion20200511001.dmp full=y 成功
----////