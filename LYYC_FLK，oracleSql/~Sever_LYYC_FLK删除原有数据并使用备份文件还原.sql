
--/*
--select * from dba_directories; --��������Ŀ¼
--��ʾ�û����Ӵ���ʱ�����´���
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



--�ڽ����߼�����ʱ������Ҫȷ�����ݿ���ַ����Ͳ���ϵͳ���ַ����Ƿ�һ�£������һ����ᱨ��ora-00091���������÷������£� 
--SQL> select * from v$nls_parameters where parameter in ('NLS_LANGUAGE','NLS_TERRITORY','NLS_CHARACTERSET');
----����������ͨ��exp help=y����imp help=y�鿴exp��imp����ϸ����
----...��ʱ��������Ҫʹ��SYSDBA��ִ��EXP/IMP������д����ռ��EXP/IMP���Լ���9i����SYS�û���ִ��EXP/IMPʱ������Ҫʹ��SYSDBA�ſɡ����ǿ���ʹ�����淽ʽ����EXP/IMP�� 
-- exp "'sys/sys as sysdba'" file=1.dmp tables=gototop.t rows=n 
--һ��expdp/impdp��exp/imp������
--1��exp��imp�ǿͻ��˹��߳������Ǽȿ����ڿͻ���ʹ�ã�Ҳ�����ڷ����ʹ�á�
--2��expdp��impdp�Ƿ���˵Ĺ��߳�������ֻ����oracle�����ʹ�ã������ڿͻ���ʹ�á�
--3��impֻ������exp�������ļ�����������expdp�����ļ���impdpֻ������expdp�������ļ�������������exp�����ļ���
--4������10g���ϵķ�������ʹ��expͨ�����ܵ���0�����ݵĿձ�����ʱ����ʹ��expdp������

-----��������������ʹ�õı��ݻ�ԭ���ݿ�
--������ʹ�ã�����ԭ�����ݿ�(����)impdp C##Fusion/admin123456COM@orcl directory=C##Fusion dumpfile=ly2020.dmp (�ɹ�)
--������ʹ�ã�����***--expdp C##Fusion/admin123456COM@orcl directory=C##Fusion dumpfile=ly2020.dmp �ɹ�








--����ʹ�õĴ�������(�ܸ��õ�Ū����ԵĹ�ϵ)
/*
--select * from dba_directories; --��������Ŀ¼
--��ʾ�û����Ӵ���ʱ�����´���
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

-----�������������Ľ���ǰ��׼��ͬ��Ҫ��
--cmd��ִ�����--ע�����Ҫ�ֺţ�
--����ԭ�����ݿ�(����)impdp C##Fusion/admin123456COM@orcl directory=Dir_C##Fusion dumpfile=ly20200428001.dmp logfile=impdp20200429001.log (�ɹ�)
--cmd��ִ�����--ע�����Ҫ�ֺţ�
--����***--expdp C##Fusion/admin123456COM@orcl directory=Dir_C##Fusion dumpfile=ly2020.dmp �ɹ�
----����������û��Ļ�������Ҫ��ʲôadd-exists-action��new���ݿ⣺old���ݿ�
----////


----////���ݻ�ԭָ����
--����ָ����
----create directory mydata as 'D:\data\oracle\oradata\mydata';  sql>select * from dba_directories;
--cmd��--expdp C##Fusion/admin123456COM directory=C##Fusion dumpfile=ly_tb_20200429.dmp logfile=expdp20200429.log tables=(DMT_TAGU); --(2020��4��29��10:25:42)���ִ���ORA-39166: Object C##FUSION.; was not found or could not be exported or imported.
--��ԭָ����
--cmd��--impdp C##Fusion/admin123456COM directory=C##Fusion dumpfile=ly_tb_20200429.dmp logfile=impdp.log tables=(DMT_TAGU); --2020-4-29 10:00:31���ִ���ORA-39166: Object C##FUSION.; was not found or could not be exported or imported.

--����ָ��������üӷֺ�(����ʹ��)
--exp C##FUSION/admin123456COM@localhost/orcl file=D:\workspace\Data\Fusion\Fusion_tagu.dmp tables=(BI_UNITU,BI_PRODUCTU,BI_PRODUCT_BARCODEU,BI_PRODUCT_SIZEU,BI_PRODUCT_UNITU) log=D:\workspace\Data\Fusion\exp20200429.log (�ɹ�)
--����ָ����   IGNORE=Y���Դ������� (N)
--imp C##FUSION/admin123456COM@localhost/orcl file=D:\workspace\Data\Fusion\Fusion_tagu.dmp tables=(BI_UNITU,BI_PRODUCTU,BI_PRODUCT_BARCODEU,BI_PRODUCT_SIZEU,BI_PRODUCT_UNITU) log=D:\workspace\Data\Fusion\imp20200429.log DESTROY=Y IGNORE=Y ���ɹ���


----////���ݻ�ԭ���ݿ�
--����
----exp C##Fusion/admin123456COM@172.30.20.57/orcl file=D:\workspace\Data\Fusion\Fusion20191124.dmp full=y �ɹ�
----exp C##Fusion/admin123456COM@localhost/orcl file=D:\workspace\Data\Fusion\Fusion20200511001.dmp full=y �ɹ�
--��ԭ
----imp C##Fusion/admin123456COM@127.0.0.1/orcl file=D:\workspace\Data\Fusion\Fusion20200511001.dmp full=y �ɹ�
----////