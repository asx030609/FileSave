
--/*
--select * from dba_directories; --��������Ŀ¼
--��ʾ�û����Ӵ���ʱ�����´���
  SELECT SID,SERIAL# FROM V$SESSION WHERE USERNAME='C##FUSION';
  
  --alter system kill session '250,10293';
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
----imp  SA/123456@scxcflk file='D:\orcldata\backup\THOKflk.dmp' full=y ignore=y; --
--create directory mydata as 'D:\data\oracle\oradata\mydata';     --��Ҫ�Ǹ�mydata/ly1.dmp�ļ���Ȩ��impdp������������
--grant read,write on directory mydata to C##Fusion;
--cmd��ִ�����--ע�����Ҫ�ֺţ�
--����ԭ�����ݿ�(����)impdp C##Fusion/admin123456COM@orcl directory=C##Fusion dumpfile=ly2020.dmp �ɹ�
--cmd��ִ�����--ע�����Ҫ�ֺţ�
--����***--expdp C##Fusion/admin123456COM@orcl directory=C##Fusion dumpfile=ly2020.dmp �ɹ�
----����������û��Ļ�������Ҫ��ʲôadd-exists-action��new���ݿ⣺old���ݿ�