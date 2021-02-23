
----下面是创建视图、创建用户，并限定这个用户只能访问这个视图。
create OR REPLACE view V_ProductMio_Admin
as
  select *from WM_PRODUCT_MONITORU;
--/*--
drop user C##Mes cascade;
create user C##Mes identified by "mes@123456.mes";

grant select on V_ProductMio_Admin to C##Mes;
grant connect to C##Mes; 
grant create synonym to C##Mes;

alter system set resource_limit=true scope=both sid='*';  ----使用resource_limit及profile限制用户连接
drop PROFILE C##Mes_profile CASCADE;
create profile C##Mes_profile limit SESSIONS_PER_USER 1 FAILED_LOGIN_ATTEMPTS unlimited; ----新建一个user profile:C##Mes_profile?
alter user C##Mes profile C##Mes_profile; ----更改用户C##Mes的profile为C##Mes_profile
alter profile C##Mes_profile limit SESSIONS_PER_USER 2; ----限定用户C##Mes的连接数为2
--*/
----然后连接到mes连接，执行
--create or REPLACE synonym V_ProductMonitor for C##Fusion.V_ProductMio_Admin; 
--select *from V_ProductMonitor; --如果可以访问就证明成功了
