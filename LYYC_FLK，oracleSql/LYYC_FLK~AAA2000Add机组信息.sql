
  -----���������Ϣ�����������Ϣ
  delete from WM_MACHINEU;
  delete from WM_MACHINE_PALLETU;
/
create or replace function f_UpdateDB
RETURN VARCHAR2
IS
  M_MACHINE_CODE_LIST varchar2(400) := '';
  M_MACHINE_NAME_LIST varchar2(400) := '';
  M_MACHINE_MODEL_LIST varchar2(400) := '';
  M_CLIENT_IP_LIST varchar2(400) := '';
  M_POSITION_CODE_LIST varchar2(400) := '';
  M_POSITION_NAME_LIST varchar2(400) := '';
    M_MACHINE_CODE varchar2(400) := '';
    M_MACHINE_NAME varchar2(400) := '';
    M_MACHINE_MODEL varchar2(400) := '';
    M_CLIENT_IP varchar2(400) := '';
      M_POSITION_CODE varchar2(400) := '';
      M_POSITION_NAME varchar2(400) := '';
  tempNum Integer;
  V_TEMP_CODE varchar2(400) := '';
  V_TEMP_NAME varchar2(400) := '';
BEGIN
  M_MACHINE_CODE_LIST := 'J102,J101,J104,J103,J106,J105,J108,J107,B202,B203,B204';
  M_MACHINE_NAME_LIST := '2#���̻�,1#���̻�,4#���̻�,3#���̻�,6#���̻�,5#���̻�,8#���̻�,7#���̻�,2#��װ��,3#��װ��,4#��װ��';
  M_MACHINE_MODEL_LIST := '��Ӱ�2�Ż���,��Ӱ�1�Ż���,��Ӱ�4�Ż���,��Ӱ�3�Ż���,��Ӱ�6�Ż���,��Ӱ�5�Ż���,��Ӱ�8�Ż���,��Ӱ�7�Ż���,װ����2�Ż���,װ����3�Ż���,װ����4�Ż���';
  M_CLIENT_IP_LIST := '10.65.27.75,10.65.27.72,10.65.27.74,10.65.27.71,10.65.27.69,10.65.27.70,10.65.27.68,10.65.27.76,10.65.27.73,10.65.27.66,10.65.27.67';
  M_CLIENT_IP_LIST := '172.30.10.122:8090,172.30.10.122:8090,172.30.10.122:8090,172.30.10.122:8090,172.30.10.122:8090,172.30.10.122:8090,172.30.10.122:8090,172.30.10.122:8090,172.30.10.122:8090,172.30.10.122:8090,172.30.10.122:8090';
  M_POSITION_CODE_LIST :='102001|102002|102003|102004|102005,101001|101002|101003|101004|101005,104001|104002|104003|104004|104005,103001|103002|103003|103004|103005'
    ||',106001|106002|106003|106004|10605,105001|105002|105003|105004|105005,108001|108002|108003|108004|108005,107001|107002|107003|107004|107005'
    ||',202001|202002,203001|203002,204001|204002';
  M_POSITION_NAME_LIST :='4001|4002|4004|4005|4006,4007|4008|4009|4011|4012,4013|4014|4016|4017|4018,4019|4020|4021|4023|4024,4025|4026|4028|4029|4030'||
    ',4031|4032|4033|4035|4036,4037|4038|4040|4041|4042,4043|4044|4045|4047|4048,3003|3004,3005|3006,3007|3008';
  tempNum := Length(M_MACHINE_CODE_LIST)/3;
  dbms_output.put_line(tempNum);
  for i in 0 .. tempNum Loop
    M_MACHINE_CODE := Get_StrArrayStrOfIndex(M_MACHINE_CODE_LIST, ',', i);
    if (trim(M_MACHINE_CODE) is null) then
      --dbms_output.put_line(' enter in if'||M_MACHINE_CODE);
      continue;
    end if;
    M_MACHINE_NAME := Get_StrArrayStrOfIndex(M_MACHINE_NAME_LIST, ',', i);
    M_MACHINE_MODEL := Get_StrArrayStrOfIndex(M_MACHINE_MODEL_LIST, ',', i);
    M_CLIENT_IP := Get_StrArrayStrOfIndex(M_CLIENT_IP_LIST, ',', i);
    V_TEMP_CODE := Get_StrArrayStrOfIndex(M_POSITION_CODE_LIST, ',', i);
    V_TEMP_NAME := Get_StrArrayStrOfIndex(M_POSITION_NAME_LIST, ',', i);
    -----����
    insert into C##FUSION.WM_MACHINEU(MACHINE_CODEU, MACHINE_NAMEU, MACHINE_TYPEU, CLIENT_IPU, ACTIVEU, USINGU, EXTERNAL_MACHINE_CODEU, CREATE_TIMEU, UPDATE_TIMEU, ROW_VERSIONU)
      values ( M_MACHINE_CODE , M_MACHINE_NAME,  M_MACHINE_MODEL, M_CLIENT_IP,  '1' ,  '0' ,  '' ,  sysdate ,  sysdate ,  SYS_GUID());
    for j in 0 .. 6 LOOP
      M_POSITION_CODE := Get_StrArrayStrOfIndex(V_TEMP_CODE, '|', j);
      if (trim(M_POSITION_CODE) is null) then
        continue;
      end if;
      M_POSITION_NAME := Get_StrArrayStrOfIndex(V_TEMP_NAME, '|', j);
      dbms_output.put_line('2��ѭ������V_TEMP_CODE��'||V_TEMP_CODE);
      dbms_output.put_line('2��ѭ������M_POSITION_NAME��'||M_POSITION_NAME);
      dbms_output.put_line('2��ѭ������V_TEMP_NAME��'||V_TEMP_NAME);
      insert into C##FUSION.WM_MACHINE_PALLETU(PALLET_POSITIONU, MACHINE_CODEU, MACHINE_PALLET_NAMEU, PALLET_TYPE_CODEU, PALLET_TYPE_NAMEU, WORK_POSITION_NOU, WORK_POSITION_NAMEU
      , CURRENT_BRAND_CODEU, CURRENT_BRAND_NAMEU, CURRENT_MATCH_PALLET_CODEU, CURRENT_MATCH_PALLET_NAMEU, CURRENT_UNIQUE_IDU, ACTIVEU, SYNC_MACHINE_PALLET_STATUSU
      , MACHINE_PALLET_STATUSU, CREATE_TIMEU, UPDATE_TIMEU, ROW_VERSIONU)
        values ( j+1, M_MACHINE_CODE, j+1,  '1003' ,  '�����' , M_POSITION_CODE, M_POSITION_NAME
        ,  '' ,  '' ,  '' ,  '' ,  '' ,  '1' ,  '1' ,  '0' ,  sysdate ,  sysdate ,  SYS_GUID());
    end Loop;
  end loop;

  dbms_output.put_line('function F_UPDATEDB arrive end');
  return 1;
 /* 
*/  
END;
/
set serveroutput on;
Declare
  ret varchar2(20);
Begin
  dbms_output.put_line('����ֵ��'||f_UpdateDB());
  COMMIT WORK;
EXCEPTION
WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/
drop function F_UPDATEDB;
