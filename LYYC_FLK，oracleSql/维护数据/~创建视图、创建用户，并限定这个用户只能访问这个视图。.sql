
----�����Ǵ�����ͼ�������û������޶�����û�ֻ�ܷ��������ͼ��
create OR REPLACE view V_ProductMio_Admin
as
  select *from WM_PRODUCT_MONITORU;
--/*--
drop user C##Mes cascade;
create user C##Mes identified by "mes@123456.mes";

grant select on V_ProductMio_Admin to C##Mes;
grant connect to C##Mes; 
grant create synonym to C##Mes;

alter system set resource_limit=true scope=both sid='*';  ----ʹ��resource_limit��profile�����û�����
drop PROFILE C##Mes_profile CASCADE;
create profile C##Mes_profile limit SESSIONS_PER_USER 1 FAILED_LOGIN_ATTEMPTS unlimited; ----�½�һ��user profile:C##Mes_profile?
alter user C##Mes profile C##Mes_profile; ----�����û�C##Mes��profileΪC##Mes_profile
alter profile C##Mes_profile limit SESSIONS_PER_USER 2; ----�޶��û�C##Mes��������Ϊ2
--*/
----Ȼ�����ӵ�mes���ӣ�ִ��
--create or REPLACE synonym V_ProductMonitor for C##Fusion.V_ProductMio_Admin; 
--select *from V_ProductMonitor; --������Է��ʾ�֤���ɹ���
