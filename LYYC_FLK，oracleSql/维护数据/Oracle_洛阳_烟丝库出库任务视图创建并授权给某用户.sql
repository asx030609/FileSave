create OR REPLACE FORCE EDITIONABLE VIEW VIEW_STOREOUTTASK ("STATION_CODESU", "STATION_NAMESU", "PRODUCT_CODEU", "PRODUCT_NAMEU", "TOTAL_QUANTITYU", "COMPLETE_QUANTITYU", "IN_BATCHU") AS 
  select STATION_CODESU,STATION_NAMESU,PRODUCT_CODEU,PRODUCT_NAMEU,TOTAL_QUANTITYU,COMPLETE_QUANTITYU,IN_BATCHU from TM_Store_Out_Tasku;
/*--除非一开始的创建用户，否则不要执行下面sql
drop user C##Mes cascade;
create user C##Mes identified by "mes@123456.mes";
--*/
--/*
grant select on VIEW_STOREOUTTASK to C##Mes;
/*--
grant connect to C##Mes; 
grant create synonym to C##Mes;
alter system set resource_limit=true scope=both sid='*';  ----使用resource_limit及profile限制用户连接

drop PROFILE C##Mes_profile CASCADE;
create profile C##Mes_profile limit SESSIONS_PER_USER 1 FAILED_LOGIN_ATTEMPTS unlimited; ----新建一个user profile:C##Mes_profile?
alter user C##Mes profile C##Mes_profile; ----更改用户C##Mes的profile为C##Mes_profile
alter profile C##Mes_profile limit SESSIONS_PER_USER 200; ----限定用户C##Mes的连接数为2
--*/
---->>>>>>然后连接到mes连接，执行
--create or REPLACE synonym V_STOREOUTTASK for C##Fusion.VIEW_STOREOUTTASK; 
--select *from V_STOREOUTTASK; --如果可以访问就证明成功了