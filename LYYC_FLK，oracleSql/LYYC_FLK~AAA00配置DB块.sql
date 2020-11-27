create or replace function SetStrOfIndex --��0,1,2,3,4,5,6�ϵ�i���ϵ������滻�����ж�Ӧ��ϵ��0,None��1,Bool��2,ByteBool��3,Byte,4,Short��5,Word��6,Dword��7,Int��8,Float��9,Sys��11,Str����������index��Ӧ����Ĭ������Ϊ0
(
  v_Input in varchar2,  --���ַ���
  i_Index in varchar2,  --�滻�ڼ���Ԫ��,������0��ʼ
  v_ReplaceStr in varchar2 --Ҫ�滻�ɵ��ַ�
)
return varchar2 --���շ��ص����ַ���
is
  lv_str varchar2(1024);
  lv_strOfIndex varchar2(1024);
  lv_length number;
  temp_varchar varchar2(1024);
begin
  lv_str:=ltrim(rtrim(v_Input));
  lv_str:=concat(lv_str,',');
  lv_length:=i_Index;
  if lv_length=0 then
      lv_str:=v_ReplaceStr||substr(lv_str,instr(lv_str,','),(length(lv_str))-instr(lv_str,','));
  else
      lv_length:=i_Index+1;
      if(0=instr(lv_str,',',1,lv_length)) then  --���������β�ˣ������ȱ���ԭֵ��UNDO���Ժ��ٸ����������N��',0'��
        return v_Input;
      end if;
      temp_varchar := substr(lv_str,instr(lv_str,',',1,lv_length),length(lv_str)-instr(lv_str,',',1,lv_length));
      lv_str:= substr(lv_str,1,instr(lv_str,',',1,i_Index))||v_ReplaceStr||temp_varchar;
  end if;
  return  lv_str;
end SetStrOfIndex;
/
create or replace function f_GetDataSize(dataType in varchar2)
return varchar2
is
  strRet varchar2(20);
begin
  strRet := 4;
  ----0,None��1,Bool��2,ByteBool��3,Byte,4,Short��5,Word��6,Dword��7,Int��8,Float��9,Sys��11,Str��
  if(dataType = '1') then
    strRet := 1;
  elsif(dataType='7') then
    strRet := 4;
  elsif(dataType='4') then
    strRet := 2;
  elsif(dataType='11') then
    strRet := 1;
  end if;
  return strRet;
end;
/
commit;
/
create or replace function f_GetDataTypeStr(dataType in varchar2)
return varchar2
is
  strRet varchar2(20);
begin
  strRet := 0;
  ----0,None��1,Bool��2,ByteBool��3,Byte,4,Short��5,Word��6,Dword��7,Int��8,Float��9,Sys��11,Str��
  if(dataType = '1') then
    strRet := 'DBX';
  elsif(dataType='7') then
    strRet := 'DINT';
  elsif(dataType='4') then
    strRet := 'INT';
  elsif(dataType='5') then
    strRet := 'DINT';
  elsif(dataType='5') then
    strRet := 'DReal';
  elsif(dataType='11') then
    strRet := 'STRING';
  end if;
  return strRet;
end;
/
  DELETE FROM C##FUSION.DMT_TAGU;
  DELETE FROM C##FUSION.DMT_GROUPU;
  DELETE FROM C##FUSION.DMT_DATA_SERVERU;
/
create or replace function f_UpdateDB
RETURN VARCHAR2
IS
  M_SERVER_CODE varchar2(20) := 'WCSServer';
  M_GROUP_CODE_LIST varchar2(400) := '';
  M_GROUP_NAME_LIST varchar2(400) := '';
  M_TYPE_DATA1_LIST varchar2(400) := '';--��ǩ�ı�־λ������������
  M_TYPE_DATA2_LIST varchar2(400) := '';--��ǩ������������������
  M_TYPE_DATA3_LIST varchar2(400) := '';--��ǩ�ķ���������������
  M_DATA_COUNT1_LIST varchar2(400) := '';--��ǩ�ı�־λ��ռ������
  M_DATA_COUNT2_LIST varchar2(400) := '';--��ǩ��������ռ������
  M_DATA_COUNT3_LIST varchar2(400) := '';--��ǩ�ķ�����ռ������
  M_ADDRESS1_LIST varchar2(400) := '';
  M_ADDRESS2_LIST varchar2(400) := '';
  M_ADDRESS3_LIST varchar2(400) := '';
  activityNum_LIST varchar2(400) := '';
    M_GROUP_CODE varchar2(30);
	  M_GROUP_NAME varchar2(30);
	  M_TYPE_DATA1 varchar2(30);
	  M_TYPE_DATA2 varchar2(30);
	  M_TYPE_DATA3 varchar2(30);
    temp_data_size varchar2(30);
	  M_DATA_COUNT1 varchar2(30);
	  M_DATA_COUNT2 varchar2(30);
	  M_DATA_COUNT3 varchar2(30);
	  M_DBAddress1 varchar2(30);
	  M_DBAddress2 varchar2(30);
	  M_DBAddress3 varchar2(30); 
  tempNum Integer;
  activityNum Integer;
  dBUsedNumList varchar2(500) := '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'; --��������ĳ��DB���ƫ����
  tempDBCodeList varchar2(1024);
BEGIN
  ----����һ������ͺ�
  M_SERVER_CODE := 'WCSServer';
  Insert into C##FUSION.DMT_DATA_SERVERU (SERVER_CODEU,SERVER_NAMEU,DATA_DRIVER_NAMEU,SERVER_ARGUMENTSU,TESTU,CLASS_NAMEU,ACTIVEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
     values (M_SERVER_CODE,'���Ͽ����','SiemensServer','{"IP":"172.30.12.101","Rack":"0","Slot":"1","TimeOut":"1000","IsClosed":"","CloseTime":"","PDU":"","Limit":""}',0,M_SERVER_CODE,1,SYSDATE,SYSDATE,SYS_GUID());

  Insert into C##FUSION.DMT_GROUPU (GROUP_CODEU,SERVER_CODEU,GROUP_NAMEU,UPDATE_RATEU,DEAD_BANDU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
     values ('Heartbeat',M_SERVER_CODE,'�ִ���������',1000,0,1,null,SYSDATE,SYSDATE,SYS_GUID());
  ----7,1,1�ֱ�����������ͣ����ݴ�С������������ʾʹ����������ƫ��1*3byte
  ----0,None��1,Bool��2,ByteBool��3,Byte,4,Short��5,Word��6,Dword��7,Int��8,Float��9,Sys��11,Str��
  ----1,1,1,0,1,0�ֱ������ʾ˳��active: '����',archive: '�鵵',cycle: '����',,AUTO_SYNCU,ACTIVEU,READ_ONLYU(��ЩĬ�Ͼ���Щ��ֵ�ͺ���)
  Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
     values ('Heartbeat_I','Heartbeat',M_SERVER_CODE,'����',1,1,1,'DB711,DBX0','���ƽ���',1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID());
  Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
     values ('Heartbeat_O','Heartbeat',M_SERVER_CODE,'��������',1,1,1,'DB711,DBX0.1','���ƽ���',1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID());

  M_GROUP_CODE_LIST := 'ScanCodeInbound ,ApplyBackStorage ,EmptyPalletInbound,TaskArrive';
  M_GROUP_NAME_LIST := '���븨�����      ,����ؿ�         ,������������      ,���񵽴�';
  M_TYPE_DATA1_LIST := '7               ,7               ,7                 ,7';
  M_TYPE_DATA2_LIST := '7               ,7               ,7                 ,7';
  M_TYPE_DATA3_LIST := '7               ,7               ,7                 ,7';
  M_DATA_COUNT1_LIST := '1              ,1              ,1                  ,1';
  M_DATA_COUNT2_LIST := '4              ,5              ,4                  ,4';
  M_DATA_COUNT3_LIST := '7              ,6              ,6                  ,5';
  activityNum_LIST := '3                 ,1              ,1                 ,2';
  M_ADDRESS1_LIST:='DB521.DINT16        ,DB581.DINT20    ,DB591.DINT16        ,DB531.DINT16';
  M_ADDRESS2_LIST:='DB521.DINT0         ,DB581.DINT0    ,DB591.DINT0        ,DB531.DINT0';
  M_ADDRESS3_LIST:='DB522.DINT0         ,DB582.DINT0    ,DB592.DINT0        ,DB532.DINT0';
  ----
  tempNum := length(M_GROUP_CODE_LIST)/4;
  for i in 0 .. tempNum LOOP
	  M_GROUP_CODE := Get_StrArrayStrOfIndex(M_GROUP_CODE_LIST, ',', i);
    if (trim(M_GROUP_CODE) is null) then
      --dbms_output.put_line(' enter in if'||M_GROUP_CODE);
      continue;
    end if;
	  M_GROUP_CODE := trim(Get_StrArrayStrOfIndex(M_GROUP_CODE_LIST, ',', i));
	  M_GROUP_NAME := trim(Get_StrArrayStrOfIndex(M_GROUP_NAME_LIST, ',', i));
	  M_TYPE_DATA1 := trim(Get_StrArrayStrOfIndex(M_TYPE_DATA1_LIST, ',', i));
	  M_TYPE_DATA2 := trim(Get_StrArrayStrOfIndex(M_TYPE_DATA2_LIST, ',', i));
	  M_TYPE_DATA3 := trim(Get_StrArrayStrOfIndex(M_TYPE_DATA3_LIST, ',', i));
	  M_DATA_COUNT1 := trim(Get_StrArrayStrOfIndex(M_DATA_COUNT1_LIST, ',', i));
	  M_DATA_COUNT2 := trim(Get_StrArrayStrOfIndex(M_DATA_COUNT2_LIST, ',', i));
	  M_DATA_COUNT3 := trim(Get_StrArrayStrOfIndex(M_DATA_COUNT3_LIST, ',', i));
	  M_DBAddress1 := trim(Get_StrArrayStrOfIndex(M_ADDRESS1_LIST, ',', i));
	  M_DBAddress2 := trim(Get_StrArrayStrOfIndex(M_ADDRESS2_LIST, ',', i));
	  M_DBAddress3 := trim(Get_StrArrayStrOfIndex(M_ADDRESS3_LIST, ',', i)); 
    activityNum := to_number(Get_StrArrayStrOfIndex(activityNum_LIST, ',', i)); 
	  Insert into C##FUSION.DMT_GROUPU (GROUP_CODEU,SERVER_CODEU,GROUP_NAMEU,UPDATE_RATEU,DEAD_BANDU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
		 values (M_GROUP_CODE,M_SERVER_CODE,M_GROUP_NAME,1000,0,1,null,SYSDATE,SYSDATE,SYS_GUID());
	  ----INSERTING into C##FUSION.DMT_TAGU
    for j in 1 .. activityNum LOOP
			temp_data_size := f_GetDataSize(M_TYPE_DATA1);
      dbms_output.put_line(lpad(j, 2, '0'));
      Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU)
				 values (M_GROUP_CODE||'Sign'||lpad(j, 2, '0'),M_GROUP_CODE,M_SERVER_CODE,M_GROUP_NAME||'�����־λ'||lpad(j, 2, '0'),M_TYPE_DATA1,temp_data_size,M_DATA_COUNT1,M_DBAddress1,M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID());
			Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
				 values (M_GROUP_CODE||lpad(j, 2, '0'),M_GROUP_CODE,M_SERVER_CODE,M_GROUP_NAME||'����'||lpad(j, 2, '0'),M_TYPE_DATA2,temp_data_size,M_DATA_COUNT2,M_DBAddress2,M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID());
      temp_data_size := f_GetDataSize(M_TYPE_DATA3);
			Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
				 values (M_GROUP_CODE||'Feedback'||lpad(j, 2, '0'),M_GROUP_CODE,M_SERVER_CODE,M_GROUP_NAME||'����'||lpad(j, 2, '0'),M_TYPE_DATA3,temp_data_size,M_DATA_COUNT3,M_DBAddress3,M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID());
    END LOOP;
     
    for kkk in 1 .. 2 LOOP  --�����ã�ֻ��Ϊ���۵�
      temp_data_size:=0;
    /*��ʱ��û���ǵ�DB�鲻ͬʱ��ƫ����ҲҪ���ű䣬���Ҫ����
    dBUsedNumList := '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0'; --��������ĳ��DB���ƫ����
    for j in 0 .. activityNum LOOP
			temp_data_size := f_GetDataSize(M_TYPE_DATA1);
      M_DBAddress1 :=  M_DBAddress1||'.'||trim(f_GetDataTypeStr(M_TYPE_DATA1))||Get_StrArrayStrOfIndex(GetStrLocateIndex(dBUsedNumList,M_DBAddress1)-1);
      Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU)
				 values (M_GROUP_CODE||'Sign',M_GROUP_CODE,M_SERVER_CODE,M_GROUP_NAME||'�����־λ',M_TYPE_DATA1,temp_data_size,M_DATA_COUNT1,M_DBAddress1,M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID());
      if(instr(tempDBCodeList,M_DBAddress1) = 0) then --���û�б�������DB��ͱ����tempDBCodeList
        if(length(tempDBCodeList) = 0) then
          tempDBCodeList := M_DBAddress1;
        else
          tempDBCodeList := tempDBCodeList||','||M_DBAddress1;
      end if;
      dBUsedNumList := SetStrOfIndex(dBUsedNumList,(GetStrLocateIndex(dBUsedNumList,M_DBAddress1)-1),(to_number(Get_StrArrayStrOfIndex(GetStrLocateIndex(dBUsedNumList,M_DBAddress1)-1))+to_number(to_number(M_DATA_COUNT1)*(temp_data_size))));--
      
      temp_data_size := f_GetDataSize(M_TYPE_DATA2);
      M_DBAddress2 :=  M_DBAddress2||'.'||trim(f_GetDataTypeStrf_GetDataTypeStr)||dBUsedNumList;
			Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
				 values (M_GROUP_CODE,M_GROUP_CODE,M_SERVER_CODE,M_GROUP_NAME||'����',M_TYPE_DATA2,temp_data_size,M_DATA_COUNT2,M_DBAddress2,M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID());
      if(instr(tempDBCodeList,M_DBAddress1) = 0) then --���û�б�������DB��ͱ����tempDBCodeList
        tempDBCodeList := tempDBCodeList||','||M_DBAddress1;
      end if;
      dBUsedNumList := SetStrOfIndex(dBUsedNumList,(GetStrLocateIndex(dBUsedNumList,M_DBAddress1)-1),(to_number(Get_StrArrayStrOfIndex(GetStrLocateIndex(dBUsedNumList,M_DBAddress1)-1))+to_number(to_number(M_DATA_COUNT1)*(temp_data_size))));--
      
      temp_data_size := f_GetDataSize(M_TYPE_DATA3);
      M_DBAddress3 :=  M_DBAddress3||'.'||trim(f_GetDataTypeStrf_GetDataTypeStr)||dBUsedNumList;
			Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
				 values (M_GROUP_CODE||'Feekback',M_GROUP_CODE,M_SERVER_CODE,M_GROUP_NAME||'����',M_TYPE_DATA3,temp_data_size,M_DATA_COUNT3,M_DBAddress3,M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID());
      dBUsedNumList := to_number(dBUsedNumList) + to_number(M_DATA_COUNT3)*(temp_data_size);
  
    END LOOP;*/
    END LOOP;
  END LOOP;
  -----

  for k in 1 .. 3 LOOP
    M_SERVER_CODE := 'WCSServer';
    if(1=k) then
      M_GROUP_CODE := 'AGV';
      M_GROUP_NAME := 'AGV';
    elsif(1!=k) then
      continue;
    end if;
    Insert into C##FUSION.DMT_GROUPU (GROUP_CODEU,SERVER_CODEU,GROUP_NAMEU,UPDATE_RATEU,DEAD_BANDU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
       values (M_GROUP_CODE,M_SERVER_CODE,M_GROUP_NAME,1000,0,1,null,SYSDATE,SYSDATE,SYS_GUID());
    ----7,1,1�ֱ�����������ͣ����ݴ�С������������ʾʹ����������ƫ��1*3byte
    ----0,None��1,Bool��2,ByteBool��3,Byte,4,Short��5,Word��6,Dword��7,Int��8,Float��9,Sys��11,Str��
    ----1,1,1,0,1,0�ֱ������ʾ˳��active: '����',archive: '�鵵',cycle: '����',,AUTO_SYNCU,ACTIVEU,READ_ONLYU(��ЩĬ�Ͼ���Щ��ֵ�ͺ���)
    Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU)
      values ('RequestGet',M_GROUP_CODE,'WCSServer','RequestGet',7,4,1,'DB541.DINT'||(4*4*(k-1)),M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID()); --ȡ������PLCУ��
    Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU)
      values ('PermitGet',M_GROUP_CODE,'WCSServer','PermitGet',7,4,1,'DB542.DINT'||(1*4*(k-1)),M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID()); --ȡ������PLCУ��
    Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU)
      values ('GetCompleted',M_GROUP_CODE,'WCSServer','GetCompleted',7,4,1,'DB543.DINT'||(4*4*(k-1)),M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID()); --  --ȡ�����
    Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU)
      values ('GetCompletedReceived',M_GROUP_CODE,'WCSServer','GetCompletedReceived',7,4,1,'DB544.DINT'||(1*4*(k-1)),M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID()); --
    
    Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU)
      values ('RequestPut',M_GROUP_CODE,'WCSServer','RequestPut',7,4,1,'DB551.DINT'||(1*4*(k-1)),M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID()); --�Ż�����PLCУ��
    Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU)
      values ('PermitPut',M_GROUP_CODE,'WCSServer','PermitPut',7,4,1,'DB552.DINT'||(1*4*(k-1)),M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID()); --�Ż�����PLCУ��
    Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU)
      values ('PutComplete',M_GROUP_CODE,'WCSServer','PutComplete',7,4,1,'DB553.DINT'||(6*4*(k-1)),M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID()); --WritingInfo($"�·�����[λ��,�����,�������루9��DINT��,��������
    Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU)
      values ('PutCompletedReceived',M_GROUP_CODE,'WCSServer','PutCompletedReceived',7,4,1,'DB554.DINT'||(1*4*(k-1)),M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID()); --  --�Ż����񽻻����������
    Insert into C##FUSION.DMT_TAGU (TAG_CODEU,GROUP_CODEU,SERVER_CODEU,TAG_NAMEU,DATA_TYPEU,DATA_SIZEU,DATA_COUNTU,ADDRESSU,CLASS_NAMEU,DISPLAY_ORDERU,ARCHIVEU,CYCLEU,AUTO_SYNCU,ACTIVEU,READ_ONLYU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU)
      values ('PutDataAccepted',M_GROUP_CODE,'WCSServer','PutDataAccepted',7,4,1,'DB554.DINT'||(4*4*(k-1)),M_GROUP_NAME,1,1,1,0,1,0,null,SYSDATE,SYSDATE,SYS_GUID()); --�Ż����ݽ������
    
  END LOOP;
  
	M_SERVER_CODE := 'WCSServer';
  --���úöѶ����server��group���������ҳ�浼�����ݺ󲻻����
  --���öѶ��01���Ѷ��02
	M_SERVER_CODE := 'CR01Server';
	Insert into C##FUSION.DMT_DATA_SERVERU (SERVER_CODEU,SERVER_NAMEU,DATA_DRIVER_NAMEU,SERVER_ARGUMENTSU,TESTU,CLASS_NAMEU,ACTIVEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
		values (M_SERVER_CODE,'1�ŶѶ������','SiemensServer','{"IP":"172.30.16.101","Rack":"0","Slot":"1","TimeOut":"1000","IsClosed":"","CloseTime":"","PDU":"","Limit":""}',0,'�Ѷ��',1,SYSDATE,SYSDATE,SYS_GUID());
	M_GROUP_CODE := 'InteractiveGroup';
  Insert into C##FUSION.DMT_GROUPU (GROUP_CODEU,SERVER_CODEU,GROUP_NAMEU,UPDATE_RATEU,DEAD_BANDU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
     values (M_GROUP_CODE,M_SERVER_CODE,'������',1000,0,1,null,SYSDATE,SYSDATE,SYS_GUID());

	M_SERVER_CODE := 'CR02Server';
	Insert into C##FUSION.DMT_DATA_SERVERU (SERVER_CODEU,SERVER_NAMEU,DATA_DRIVER_NAMEU,SERVER_ARGUMENTSU,TESTU,CLASS_NAMEU,ACTIVEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
		values (M_SERVER_CODE,'2�ŶѶ������','SiemensServer','{"IP":"172.30.16.102","Rack":"0","Slot":"1","TimeOut":"1000","IsClosed":"","CloseTime":"","PDU":"","Limit":""}',0,'�Ѷ��',1,SYSDATE,SYSDATE,SYS_GUID());
	M_GROUP_CODE := 'InteractiveGroup';
  Insert into C##FUSION.DMT_GROUPU (GROUP_CODEU,SERVER_CODEU,GROUP_NAMEU,UPDATE_RATEU,DEAD_BANDU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) 
     values (M_GROUP_CODE,M_SERVER_CODE,'������',1000,0,1,null,SYSDATE,SYSDATE,SYS_GUID());

  dbms_output.put_line('function F_UPDATEDB arrive end');
  return 1;
 /* 
*/  
END;
/
/*
*/

create or replace function f_ExecuteSum
return varchar2
is
BEGIN
  return f_UpdateDB();
END;
/
set serveroutput on;
Declare
  ret varchar2(20);
Begin
  dbms_output.put_line('����ֵ��'||f_UpdateDB());
  --dbms_output.put_line('����ֵ��'||f_ExecuteSum());
  COMMIT WORK;
EXCEPTION
WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/
drop function F_GETDATASIZE;
drop function F_GETDATATYPESTR;
drop function F_UPDATEDB;
drop function F_EXECUTESUM;
