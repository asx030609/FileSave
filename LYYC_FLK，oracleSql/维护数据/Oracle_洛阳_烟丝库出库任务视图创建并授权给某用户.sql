create OR REPLACE FORCE EDITIONABLE VIEW VIEW_STOREOUTTASK ("STATION_CODESU", "STATION_NAMESU", "PRODUCT_CODEU", "PRODUCT_NAMEU", "TOTAL_QUANTITYU", "COMPLETE_QUANTITYU", "IN_BATCHU") AS 
  select STATION_CODESU,STATION_NAMESU,PRODUCT_CODEU,PRODUCT_NAMEU,TOTAL_QUANTITYU,COMPLETE_QUANTITYU,IN_BATCHU from TM_Store_Out_Tasku;
/*--����һ��ʼ�Ĵ����û�������Ҫִ������sql
drop user C##Mes cascade;
create user C##Mes identified by "mes@123456.mes";
--*/
--/*
grant select on VIEW_STOREOUTTASK to C##Mes;
/*--
grant connect to C##Mes; 
grant create synonym to C##Mes;
alter system set resource_limit=true scope=both sid='*';  ----ʹ��resource_limit��profile�����û�����

drop PROFILE C##Mes_profile CASCADE;
create profile C##Mes_profile limit SESSIONS_PER_USER 1 FAILED_LOGIN_ATTEMPTS unlimited; ----�½�һ��user profile:C##Mes_profile?
alter user C##Mes profile C##Mes_profile; ----�����û�C##Mes��profileΪC##Mes_profile
alter profile C##Mes_profile limit SESSIONS_PER_USER 200; ----�޶��û�C##Mes��������Ϊ2
--*/
---->>>>>>Ȼ�����ӵ�mes���ӣ�ִ��
--create or REPLACE synonym V_STOREOUTTASK for C##Fusion.VIEW_STOREOUTTASK; 
--select *from V_STOREOUTTASK; --������Է��ʾ�֤���ɹ���