
create or replace function f_A1
RETURN varchar2
is 
  v_Name varchar2(100);
  iLocationNo Number(2):=1;
  iLayerNo Number(2):=1;
  iExisitedNum Integer:=0;
  v_Temp varchar2(50);
BEGIN
  --更新一键生成时，后期更新第一排货架的货位、盘位
  LOOP
        LOOP          
          v_Temp := '01-'||lpad(iLocationNo, 2, '0')||'-'||lpad(iLayerNo, 2, '0');
          update WM_LOCATIONU SET MAX_PALLET_QUANTITYU=2 where LOCATION_CODEU=v_Temp;
          iExisitedNum := 0;
          select count(LOCATION_CODEU) into iExisitedNum from C##FUSION.WM_PALLETU where LOCATION_CODEU=v_Temp;
          if(1 >= iExisitedNum) then
            --dbms_output.put_line('再次插入数据'||v_Temp);
            INSERT INTO C##FUSION.WM_PALLETU (IDU,LOCATION_CODEU,PALLET_NAMEU,MATCH_PALLET_CODEU,MATCH_PALLET_NAMEU,UNIQUE_IDU,PRODUCT_COUNTU,STORAGE_QUANTITYU,IN_FROZEN_QUANTITYU,OUT_FROZEN_QUANTITYU,STORAGE_SEQUENCEU,PRODUCT_POSITIONU,BRAND_CODESU,BRAND_NAMESU,PALLET_TYPE_CODEU,PALLET_TYPE_NAMEU,PALLET_NOU,INBOUND_POSITION_NOU,OUTBOUND_POSITION_NOU,RESERVEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
              (SYS_GUID(),v_Temp,'盘位',null,null,null,0,0,0,0,0,null,null,null,null,null,0,0,0,null,sysdate,sysdate,SYS_GUID());
          END IF;
          --/*更新作业位置的X、Y、Z坐标
          update C##FUSION.TM_WORK_POSITIONU
            set SingleTravelPosition = iLocationNo, SingleLiftPosition = iLayerNo, SingleForkExtension =  '2' , DoubleTravelPosition =  '0' , DoubleLiftPosition =  '0' , DoubleForkExtension =  '0' , SERVER_CODEU =  '' , SERVER_NAMEU =  '' , SUPPLY_POSITION_CODEU =  '' , REMARKU =  '' , UPDATE_TIMEU =  SYSDATE , ROW_VERSIONU =  SYS_GUID()
            where ((WORK_POSITION_NOU =  v_Temp ) );
          iLayerNo := iLayerNo + 1;
          EXIT WHEN iLayerNo > 4;
        END LOOP;
        iLayerNo := 1;
        --
        iLocationNo := iLocationNo + 1;
  EXIT WHEN iLocationNo > 32; 
  END LOOP;
  iLocationNo :=1;
  iLayerNo :=1;
  --更新一键生成时，后期更新第3排货架的货位、盘位
  LOOP
        LOOP          
          v_Temp := '03-'||lpad(iLocationNo, 2, '0')||'-'||lpad(iLayerNo, 2, '0');
          update WM_LOCATIONU SET MAX_PALLET_QUANTITYU=2 where LOCATION_CODEU=v_Temp;
          iExisitedNum := 0;
          select count(LOCATION_CODEU) into iExisitedNum from C##FUSION.WM_PALLETU where LOCATION_CODEU=v_Temp;
          if(1 >= iExisitedNum) then
            --dbms_output.put_line('03货架再次插入数据'||v_Temp);
            INSERT INTO C##FUSION.WM_PALLETU (IDU,LOCATION_CODEU,PALLET_NAMEU,MATCH_PALLET_CODEU,MATCH_PALLET_NAMEU,UNIQUE_IDU,PRODUCT_COUNTU,STORAGE_QUANTITYU,IN_FROZEN_QUANTITYU,OUT_FROZEN_QUANTITYU,STORAGE_SEQUENCEU,PRODUCT_POSITIONU,BRAND_CODESU,BRAND_NAMESU,PALLET_TYPE_CODEU,PALLET_TYPE_NAMEU,PALLET_NOU,INBOUND_POSITION_NOU,OUTBOUND_POSITION_NOU,RESERVEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
              (SYS_GUID(),v_Temp,'盘位',null,null,null,0,0,0,0,0,null,null,null,null,null,0,0,0,null,sysdate,sysdate,SYS_GUID());
          END IF;
          iLayerNo := iLayerNo + 1;
          EXIT WHEN iLayerNo > 4;
        END LOOP;
        iLayerNo := 1;
        iLocationNo := iLocationNo + 1;
  EXIT WHEN iLocationNo > 32; 
  END LOOP;
  return '^_^';
  EXCEPTION WHEN OTHERS THEN 
    --DBMS_OUTPUT.put_line('SQLCODE = ' || SQLCODE) ;
    --DBMS_OUTPUT.put_line('SQLERRM = ' || SQLERRM) ;
    raise;
END;
/


create or replace function f_A2
RETURN VARCHAR2
is
  v_AGVPositionList varchar2(500) := '';
  v_InBoundPositionList varchar2(500) := '';
  v_OutBoundPositionList varchar2(500) := '';
  v_CR01PositionList varchar2(500) := '';
  v_CR02PositionList varchar2(500) := '';
  v_positionNo varchar2(30);
  i_postions_ordernum INTEGER := 140;
  v_workRegionCode varchar2(30);
  v_workRegionName varchar2(30);
  v_operEquipCode varchar2(50);
  v_operEquipName varchar2(50);
  totalPositionNum INTEGER;
  tempExistedRowNum INTEGER;
  v_Temp varchar2(1500);
BEGIN
  ----插入需要和AGV交互的作业位置和货位、盘位
  v_AGVPositionList := '101001,101002,101003,101004,101005,102001,102002,102003,102004,102005,103001,103002,103003,103004,103005,104001,104002,104003,104004'||
    ',104005,105001,105002,105003,105004,105005,106001,106002,106003,106004,106005,107001,107002,107003,107004,107005,108001,108002,108003,108004,108005'||
    ',202001,202002,203001,203002,204001,204002';
  v_InBoundPositionList := '2101,2112';
  v_CR01PositionList := '2104,2110,2229,2205';
  v_CR02PositionList := '2108,2107,2201,,2219';
  v_OutBoundPositionList := '2208,2213,2226,2210,2211';
  ----插入作业区域
	v_workRegionCode := 'R-AGV';
  v_workRegionName := 'R-AGV';
	Insert into C##FUSION.TM_WORK_REGIONU (WORK_REGION_CODEU,WORK_REGION_NAMEU,STACK_PALLET_POSITIONU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
    (v_workRegionCode,v_workRegionName,0,1,null,SYSDATE,SYSDATE,SYS_GUID());
	----添加作业所需设备
	v_operEquipCode := 'AGV';
	v_operEquipName := 'AGV';
	Insert into C##FUSION.TM_WORK_EQUIPMENTU (WORK_EQUIPMENT_CODEU,WORK_EQUIPMENT_NAMEU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
	(v_operEquipCode,v_operEquipName,1,null,SYSDATE,SYSDATE,SYS_GUID());
  totalPositionNum := Length(v_AGVPositionList)/4;
  ----插入AGV运行所需数据，包含作业位置、操作设备、虚拟货位、对应盘位
  FOR i IN 0 .. totalPositionNum-1 LOOP
    v_positionNo := Get_StrArrayStrOfIndex(v_AGVPositionList, ',', i);
    if (v_positionNo != ' ') then
      --dbms_output.put_line('AGV 第'||i||'次v_positionNo为'||v_positionNo);
			----插入作业位置对应的虚拟货位
			Insert into C##FUSION.WM_LOCATIONU (LOCATION_CODEU,LOCATION_NAMEU,LOCATION_TYPEU,WAREHOUSE_CODEU,REGION_CODEU,SHELF_CODEU,PRESET_PRODUCT_CODEU,PRESET_PRODUCT_NAMEU,IN_POSITION_NOU,OUT_POSITION_NOU,IN_WORK_EQUIPMENT_CODESU,OUT_WORK_EQUIPMENT_CODESU,PALLET_MAX_RESERVESU,MAX_PALLET_QUANTITYU,OUT_STRATEGYU,OUT_ALLOT_STRATEGYU,DISPLAY_ORDERU,ALLOT_IN_ORDERU,LOCATION_RFIDU,LOCATION_LAYERU,LOCATION_COLUMNU,COORDINATE_XU,COORDINATE_YU,LOCATION_STATUSU,FRONT_POSITIONU,REAR_POSITIONU,LOCK_TAGU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (v_positionNo,v_positionNo,0,'w002','w002r01','w002r01-01',null,null,v_positionNo,v_positionNo,v_operEquipCode,v_operEquipCode,30,1,0,0,i_postions_ordernum,0,null,1,1,0,0,1,0,0,null,null,sysdate,sysdate,SYS_GUID());
			----插入作业位置
			Insert into C##FUSION.TM_WORK_POSITIONU (WORK_POSITION_NOU,WORK_POSITION_NAMEU,POSITION_TYPEU,WORK_REGION_CODEU,"SingleTravelPosition","SingleLiftPosition","SingleForkExtension","DoubleTravelPosition","DoubleLiftPosition","DoubleForkExtension",ABLE_STOCK_OUTU,ABLE_STOCK_IN_PALLETU,HAS_GET_REQUESTU,HAS_PUT_REQUESTU,SERVER_CODEU,SERVER_NAMEU,SUPPLY_POSITION_CODEU,CACHE_CAPACITYU,CACHED_QUANTITYU,POSITION_CAPACITYU,USED_QUANTITYU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (v_positionNo,v_positionNo,0,v_workRegionCode,0,0,0,0,0,0,1,1,1,1,null,null,null,0,0,0,0,1,null,sysdate,sysdate,SYS_GUID());
			----插入盘位
			INSERT INTO C##FUSION.WM_PALLETU (IDU,LOCATION_CODEU,PALLET_NAMEU,MATCH_PALLET_CODEU,MATCH_PALLET_NAMEU,UNIQUE_IDU,PRODUCT_COUNTU,STORAGE_QUANTITYU,IN_FROZEN_QUANTITYU,OUT_FROZEN_QUANTITYU,STORAGE_SEQUENCEU,PRODUCT_POSITIONU,BRAND_CODESU,BRAND_NAMESU,PALLET_TYPE_CODEU,PALLET_TYPE_NAMEU,PALLET_NOU,INBOUND_POSITION_NOU,OUTBOUND_POSITION_NOU,RESERVEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (SYS_GUID(),v_positionNo,'盘位',null,null,null,0,0,0,0,0,null,null,null,null,null,0,0,0,null,sysdate,sysdate,SYS_GUID());
      --插入作业路径上使用的设备
      Insert into C##FUSION.TM_OPERATION_EQUIPMENTU (IDU,WORK_POSITION_NOU,WORK_EQUIPMENT_CODEU,WORK_EQUIPMENT_NAMEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
        (SYS_GUID(),v_positionNo,v_operEquipCode,v_operEquipName,SYSDATE,SYSDATE,SYS_GUID());
    end if;
    i_postions_ordernum := i_postions_ordernum + 1;
  END LOOP;
  
  --插入InBound的虚拟货位、作业位置
  ----插入作业区域
	v_workRegionCode := 'R-InBound';
  v_workRegionName := '入库区域';
	Insert into C##FUSION.TM_WORK_REGIONU (WORK_REGION_CODEU,WORK_REGION_NAMEU,STACK_PALLET_POSITIONU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
    (v_workRegionCode,v_workRegionName,0,1,null,SYSDATE,SYSDATE,SYS_GUID());
  ----^_^,没必要插入作业所需设备^_^
  totalPositionNum := Length(v_InBoundPositionList)/4;
  ----插入区域运行所需数据，包含作业位置、操作设备、虚拟货位、对应盘位
  FOR i IN 0 .. totalPositionNum-1 LOOP
    v_positionNo := Get_StrArrayStrOfIndex(v_InBoundPositionList, ',', i);
    if (v_positionNo != ' ') then
      --dbms_output.put_line('入库区域 第'||i||'次v_positionNo为'||v_positionNo);
			----插入作业位置对应的虚拟货位
			Insert into C##FUSION.WM_LOCATIONU (LOCATION_CODEU,LOCATION_NAMEU,LOCATION_TYPEU,WAREHOUSE_CODEU,REGION_CODEU,SHELF_CODEU,PRESET_PRODUCT_CODEU,PRESET_PRODUCT_NAMEU,IN_POSITION_NOU,OUT_POSITION_NOU,IN_WORK_EQUIPMENT_CODESU,OUT_WORK_EQUIPMENT_CODESU,PALLET_MAX_RESERVESU,MAX_PALLET_QUANTITYU,OUT_STRATEGYU,OUT_ALLOT_STRATEGYU,DISPLAY_ORDERU,ALLOT_IN_ORDERU,LOCATION_RFIDU,LOCATION_LAYERU,LOCATION_COLUMNU,COORDINATE_XU,COORDINATE_YU,LOCATION_STATUSU,FRONT_POSITIONU,REAR_POSITIONU,LOCK_TAGU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (v_positionNo,v_positionNo,0,'w002','w002r01','w002r01-01',null,null,v_positionNo,v_positionNo,v_operEquipCode,v_operEquipCode,30,1,0,0,i_postions_ordernum,0,null,1,1,0,0,1,0,0,null,null,sysdate,sysdate,SYS_GUID());
			----插入作业位置
			Insert into C##FUSION.TM_WORK_POSITIONU (WORK_POSITION_NOU,WORK_POSITION_NAMEU,POSITION_TYPEU,WORK_REGION_CODEU,"SingleTravelPosition","SingleLiftPosition","SingleForkExtension","DoubleTravelPosition","DoubleLiftPosition","DoubleForkExtension",ABLE_STOCK_OUTU,ABLE_STOCK_IN_PALLETU,HAS_GET_REQUESTU,HAS_PUT_REQUESTU,SERVER_CODEU,SERVER_NAMEU,SUPPLY_POSITION_CODEU,CACHE_CAPACITYU,CACHED_QUANTITYU,POSITION_CAPACITYU,USED_QUANTITYU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (v_positionNo,v_positionNo,0,v_workRegionCode,0,0,0,0,0,0,1,1,1,1,null,null,null,0,0,0,0,1,null,sysdate,sysdate,SYS_GUID());
			----插入盘位
			INSERT INTO C##FUSION.WM_PALLETU (IDU,LOCATION_CODEU,PALLET_NAMEU,MATCH_PALLET_CODEU,MATCH_PALLET_NAMEU,UNIQUE_IDU,PRODUCT_COUNTU,STORAGE_QUANTITYU,IN_FROZEN_QUANTITYU,OUT_FROZEN_QUANTITYU,STORAGE_SEQUENCEU,PRODUCT_POSITIONU,BRAND_CODESU,BRAND_NAMESU,PALLET_TYPE_CODEU,PALLET_TYPE_NAMEU,PALLET_NOU,INBOUND_POSITION_NOU,OUTBOUND_POSITION_NOU,RESERVEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (SYS_GUID(),v_positionNo,'盘位',null,null,null,0,0,0,0,0,null,null,null,null,null,0,0,0,null,sysdate,sysdate,SYS_GUID());
      ----插入作业路径上使用的设备
--      Insert into C##FUSION.TM_OPERATION_EQUIPMENTU (IDU,WORK_POSITION_NOU,WORK_EQUIPMENT_CODEU,WORK_EQUIPMENT_NAMEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
--        (SYS_GUID(),v_positionNo,v_operEquipCode,v_operEquipName,SYSDATE,SYSDATE,SYS_GUID()
    end if;
    i_postions_ordernum := i_postions_ordernum + 1;
  END LOOP;
  
  --插入CR01的虚拟货位、作业位置
  ----插入作业区域
	v_workRegionCode := 'R-CR01';
  v_workRegionName := '';
  --^_^已经一键生成过，所以直接使用^_^
	SELECT WORK_REGION_NAMEU INTO v_workRegionName FROM C##FUSION.TM_WORK_REGIONU WHERE WORK_REGION_CODEU=v_workRegionCode;
	----添加作业所需设备
	v_operEquipCode := 'CR01';
	v_operEquipName := '';
  --^_^已经一键生成过，所以直接使用^_^
  select WORK_EQUIPMENT_NAMEU into v_operEquipName from C##FUSION.TM_WORK_EQUIPMENTU where WORK_EQUIPMENT_CODEU=v_operEquipCode;
  totalPositionNum := Length(v_CR01PositionList)/4;
  ----插入区域运行所需数据，包含作业位置、操作设备、虚拟货位、对应盘位
  FOR i IN 0 .. totalPositionNum-1 LOOP
    v_positionNo := Get_StrArrayStrOfIndex(v_CR01PositionList, ',', i);
    if (v_positionNo != ' ') then
      --dbms_output.put_line('CR01 0第'||i||'次v_positionNo为'||v_positionNo);
			----插入作业位置对应的虚拟货位
			Insert into C##FUSION.WM_LOCATIONU (LOCATION_CODEU,LOCATION_NAMEU,LOCATION_TYPEU,WAREHOUSE_CODEU,REGION_CODEU,SHELF_CODEU,PRESET_PRODUCT_CODEU,PRESET_PRODUCT_NAMEU,IN_POSITION_NOU,OUT_POSITION_NOU,IN_WORK_EQUIPMENT_CODESU,OUT_WORK_EQUIPMENT_CODESU,PALLET_MAX_RESERVESU,MAX_PALLET_QUANTITYU,OUT_STRATEGYU,OUT_ALLOT_STRATEGYU,DISPLAY_ORDERU,ALLOT_IN_ORDERU,LOCATION_RFIDU,LOCATION_LAYERU,LOCATION_COLUMNU,COORDINATE_XU,COORDINATE_YU,LOCATION_STATUSU,FRONT_POSITIONU,REAR_POSITIONU,LOCK_TAGU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (v_positionNo,v_positionNo,0,'w002','w002r01','w002r01-01',null,null,v_positionNo,v_positionNo,v_operEquipCode,v_operEquipCode,30,1,0,0,i_postions_ordernum,0,null,1,1,0,0,1,0,0,null,null,sysdate,sysdate,SYS_GUID());
			----插入作业位置
      dbms_output.put_line('CR01 第'||i||'次v_positionNo为'||v_positionNo);
			Insert into C##FUSION.TM_WORK_POSITIONU (WORK_POSITION_NOU,WORK_POSITION_NAMEU,POSITION_TYPEU,WORK_REGION_CODEU,"SingleTravelPosition","SingleLiftPosition","SingleForkExtension","DoubleTravelPosition","DoubleLiftPosition","DoubleForkExtension",ABLE_STOCK_OUTU,ABLE_STOCK_IN_PALLETU,HAS_GET_REQUESTU,HAS_PUT_REQUESTU,SERVER_CODEU,SERVER_NAMEU,SUPPLY_POSITION_CODEU,CACHE_CAPACITYU,CACHED_QUANTITYU,POSITION_CAPACITYU,USED_QUANTITYU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (v_positionNo,v_positionNo,0,v_workRegionCode,0,0,0,0,0,0,1,1,1,1,null,null,null,0,0,0,0,1,null,sysdate,sysdate,SYS_GUID());
			----插入盘位
			INSERT INTO C##FUSION.WM_PALLETU (IDU,LOCATION_CODEU,PALLET_NAMEU,MATCH_PALLET_CODEU,MATCH_PALLET_NAMEU,UNIQUE_IDU,PRODUCT_COUNTU,STORAGE_QUANTITYU,IN_FROZEN_QUANTITYU,OUT_FROZEN_QUANTITYU,STORAGE_SEQUENCEU,PRODUCT_POSITIONU,BRAND_CODESU,BRAND_NAMESU,PALLET_TYPE_CODEU,PALLET_TYPE_NAMEU,PALLET_NOU,INBOUND_POSITION_NOU,OUTBOUND_POSITION_NOU,RESERVEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (SYS_GUID(),v_positionNo,'盘位',null,null,null,0,0,0,0,0,null,null,null,null,null,0,0,0,null,sysdate,sysdate,SYS_GUID());
      --插入作业路径上使用的设备
      Insert into C##FUSION.TM_OPERATION_EQUIPMENTU (IDU,WORK_POSITION_NOU,WORK_EQUIPMENT_CODEU,WORK_EQUIPMENT_NAMEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
        (SYS_GUID(),v_positionNo,v_operEquipCode,v_operEquipName,SYSDATE,SYSDATE,SYS_GUID());
    end if;
    i_postions_ordernum := i_postions_ordernum + 1;
  END LOOP;
    
  --插入CR02的虚拟货位、作业位置
  ----插入作业区域
	v_workRegionCode := 'R-CR02';
  v_workRegionName := '';
  --^_^已经一键生成过，所以直接使用^_^
	SELECT WORK_REGION_NAMEU INTO v_workRegionName FROM C##FUSION.TM_WORK_REGIONU WHERE WORK_REGION_CODEU=v_workRegionCode;
	----添加作业所需设备
	v_operEquipCode := 'CR02';
	v_operEquipName := '';
  select WORK_EQUIPMENT_NAMEU into v_operEquipName from C##FUSION.TM_WORK_EQUIPMENTU where WORK_EQUIPMENT_CODEU=v_operEquipCode;
  totalPositionNum := Length(v_CR02PositionList)/4;
  ----插入区域运行所需数据，包含作业位置、操作设备、虚拟货位、对应盘位
  FOR i IN 0 .. totalPositionNum-1 LOOP
    v_positionNo := Get_StrArrayStrOfIndex(v_CR02PositionList, ',', i);
    if (v_positionNo != ' ') then
			----插入作业位置对应的虚拟货位
			Insert into C##FUSION.WM_LOCATIONU (LOCATION_CODEU,LOCATION_NAMEU,LOCATION_TYPEU,WAREHOUSE_CODEU,REGION_CODEU,SHELF_CODEU,PRESET_PRODUCT_CODEU,PRESET_PRODUCT_NAMEU,IN_POSITION_NOU,OUT_POSITION_NOU,IN_WORK_EQUIPMENT_CODESU,OUT_WORK_EQUIPMENT_CODESU,PALLET_MAX_RESERVESU,MAX_PALLET_QUANTITYU,OUT_STRATEGYU,OUT_ALLOT_STRATEGYU,DISPLAY_ORDERU,ALLOT_IN_ORDERU,LOCATION_RFIDU,LOCATION_LAYERU,LOCATION_COLUMNU,COORDINATE_XU,COORDINATE_YU,LOCATION_STATUSU,FRONT_POSITIONU,REAR_POSITIONU,LOCK_TAGU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (v_positionNo,v_positionNo,0,'w002','w002r01','w002r01-01',null,null,v_positionNo,v_positionNo,v_operEquipCode,v_operEquipCode,30,1,0,0,i_postions_ordernum,0,null,1,1,0,0,1,0,0,null,null,sysdate,sysdate,SYS_GUID());
			----插入作业位置
			Insert into C##FUSION.TM_WORK_POSITIONU (WORK_POSITION_NOU,WORK_POSITION_NAMEU,POSITION_TYPEU,WORK_REGION_CODEU,"SingleTravelPosition","SingleLiftPosition","SingleForkExtension","DoubleTravelPosition","DoubleLiftPosition","DoubleForkExtension",ABLE_STOCK_OUTU,ABLE_STOCK_IN_PALLETU,HAS_GET_REQUESTU,HAS_PUT_REQUESTU,SERVER_CODEU,SERVER_NAMEU,SUPPLY_POSITION_CODEU,CACHE_CAPACITYU,CACHED_QUANTITYU,POSITION_CAPACITYU,USED_QUANTITYU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (v_positionNo,v_positionNo,0,v_workRegionCode,0,0,0,0,0,0,1,1,1,1,null,null,null,0,0,0,0,1,null,sysdate,sysdate,SYS_GUID());
			----插入盘位
			INSERT INTO C##FUSION.WM_PALLETU (IDU,LOCATION_CODEU,PALLET_NAMEU,MATCH_PALLET_CODEU,MATCH_PALLET_NAMEU,UNIQUE_IDU,PRODUCT_COUNTU,STORAGE_QUANTITYU,IN_FROZEN_QUANTITYU,OUT_FROZEN_QUANTITYU,STORAGE_SEQUENCEU,PRODUCT_POSITIONU,BRAND_CODESU,BRAND_NAMESU,PALLET_TYPE_CODEU,PALLET_TYPE_NAMEU,PALLET_NOU,INBOUND_POSITION_NOU,OUTBOUND_POSITION_NOU,RESERVEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (SYS_GUID(),v_positionNo,'盘位',null,null,null,0,0,0,0,0,null,null,null,null,null,0,0,0,null,sysdate,sysdate,SYS_GUID());
      --插入作业路径上使用的设备
      Insert into C##FUSION.TM_OPERATION_EQUIPMENTU (IDU,WORK_POSITION_NOU,WORK_EQUIPMENT_CODEU,WORK_EQUIPMENT_NAMEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
        (SYS_GUID(),v_positionNo,v_operEquipCode,v_operEquipName,SYSDATE,SYSDATE,SYS_GUID());
    end if;
    i_postions_ordernum := i_postions_ordernum + 1;
  END LOOP;
  
  
  --插入OutBound的虚拟货位、作业位置
  ----插入作业区域
	v_workRegionCode := 'R-OutBund';
  v_workRegionName := '出库区域';
	Insert into C##FUSION.TM_WORK_REGIONU (WORK_REGION_CODEU,WORK_REGION_NAMEU,STACK_PALLET_POSITIONU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
    (v_workRegionCode,v_workRegionName,0,1,null,SYSDATE,SYSDATE,SYS_GUID());
  ----^_^,没必要插入作业所需设备^_^
  totalPositionNum := Length(v_OutBoundPositionList)/4;
  ----插入区域运行所需数据，包含作业位置、操作设备、虚拟货位、对应盘位
  FOR i IN 0 .. totalPositionNum-1 LOOP
    v_positionNo := Get_StrArrayStrOfIndex(v_OutBoundPositionList, ',', i);
    if (v_positionNo != ' ') then
			----插入作业位置对应的虚拟货位
			Insert into C##FUSION.WM_LOCATIONU (LOCATION_CODEU,LOCATION_NAMEU,LOCATION_TYPEU,WAREHOUSE_CODEU,REGION_CODEU,SHELF_CODEU,PRESET_PRODUCT_CODEU,PRESET_PRODUCT_NAMEU,IN_POSITION_NOU,OUT_POSITION_NOU,IN_WORK_EQUIPMENT_CODESU,OUT_WORK_EQUIPMENT_CODESU,PALLET_MAX_RESERVESU,MAX_PALLET_QUANTITYU,OUT_STRATEGYU,OUT_ALLOT_STRATEGYU,DISPLAY_ORDERU,ALLOT_IN_ORDERU,LOCATION_RFIDU,LOCATION_LAYERU,LOCATION_COLUMNU,COORDINATE_XU,COORDINATE_YU,LOCATION_STATUSU,FRONT_POSITIONU,REAR_POSITIONU,LOCK_TAGU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (v_positionNo,v_positionNo,0,'w002','w002r01','w002r01-01',null,null,v_positionNo,v_positionNo,v_operEquipCode,v_operEquipCode,30,1,0,0,i_postions_ordernum,0,null,1,1,0,0,1,0,0,null,null,sysdate,sysdate,SYS_GUID());
			----插入作业位置
			Insert into C##FUSION.TM_WORK_POSITIONU (WORK_POSITION_NOU,WORK_POSITION_NAMEU,POSITION_TYPEU,WORK_REGION_CODEU,"SingleTravelPosition","SingleLiftPosition","SingleForkExtension","DoubleTravelPosition","DoubleLiftPosition","DoubleForkExtension",ABLE_STOCK_OUTU,ABLE_STOCK_IN_PALLETU,HAS_GET_REQUESTU,HAS_PUT_REQUESTU,SERVER_CODEU,SERVER_NAMEU,SUPPLY_POSITION_CODEU,CACHE_CAPACITYU,CACHED_QUANTITYU,POSITION_CAPACITYU,USED_QUANTITYU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (v_positionNo,v_positionNo,0,v_workRegionCode,0,0,0,0,0,0,1,1,1,1,null,null,null,0,0,0,0,1,null,sysdate,sysdate,SYS_GUID());
			----插入盘位
			INSERT INTO C##FUSION.WM_PALLETU (IDU,LOCATION_CODEU,PALLET_NAMEU,MATCH_PALLET_CODEU,MATCH_PALLET_NAMEU,UNIQUE_IDU,PRODUCT_COUNTU,STORAGE_QUANTITYU,IN_FROZEN_QUANTITYU,OUT_FROZEN_QUANTITYU,STORAGE_SEQUENCEU,PRODUCT_POSITIONU,BRAND_CODESU,BRAND_NAMESU,PALLET_TYPE_CODEU,PALLET_TYPE_NAMEU,PALLET_NOU,INBOUND_POSITION_NOU,OUTBOUND_POSITION_NOU,RESERVEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
			  (SYS_GUID(),v_positionNo,'盘位',null,null,null,0,0,0,0,0,null,null,null,null,null,0,0,0,null,sysdate,sysdate,SYS_GUID());
      ----插入作业路径上使用的设备
--      Insert into C##FUSION.TM_OPERATION_EQUIPMENTU (IDU,WORK_POSITION_NOU,WORK_EQUIPMENT_CODEU,WORK_EQUIPMENT_NAMEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
--        (SYS_GUID(),v_positionNo,v_operEquipCode,v_operEquipName,SYSDATE,SYSDATE,SYS_GUID());
    end if;
    i_postions_ordernum := i_postions_ordernum + 1;
  END LOOP;  

	----插入作业路径
	--插入作业路径
	Insert into C##FUSION.TM_WORK_PATHU (WORK_PATH_CODEU,WORK_PATH_NAMEU,ORIGIN_WORK_REGION_CODEU,TARGET_WORK_REGION_CODEU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
    ('r-IN01-R-CR01','入库区->R-CR01','R-InBound','R-CR01',1,null,SYSDATE,SYSDATE,SYS_GUID());
	Insert into C##FUSION.TM_WORK_PATHU (WORK_PATH_CODEU,WORK_PATH_NAMEU,ORIGIN_WORK_REGION_CODEU,TARGET_WORK_REGION_CODEU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
    ('r-IN01-R-CR02','入库区->R-CR02','R-InBound','R-CR02',1,null,SYSDATE,SYSDATE,SYS_GUID());
	Insert into C##FUSION.TM_WORK_PATHU (WORK_PATH_CODEU,WORK_PATH_NAMEU,ORIGIN_WORK_REGION_CODEU,TARGET_WORK_REGION_CODEU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
    ('R-CR01-r-out','R-CR01->出库区','R-CR01','R-OutBound',1,null,SYSDATE,SYSDATE,SYS_GUID());
	Insert into C##FUSION.TM_WORK_PATHU (WORK_PATH_CODEU,WORK_PATH_NAMEU,ORIGIN_WORK_REGION_CODEU,TARGET_WORK_REGION_CODEU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
    ('R-CR02-r-out','R-CR02->出库区','R-CR02','R-OutBound',1,null,SYSDATE,SYSDATE,SYS_GUID());
    
  insert into C##FUSION.TM_WORK_PATH_NODEU(IDU, WORK_PATH_CODEU, WORK_POSITION_NOU, WORK_POSITION_NAMEU, PATH_NODE_ORDERU, CREATE_TIMEU, UPDATE_TIMEU, ROW_VERSIONU)
    values ( SYS_GUID(),  'r-IN01-R-CR01' ,  '2110' ,  '2110' ,  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());
  insert into C##FUSION.TM_WORK_PATH_NODEU(IDU, WORK_PATH_CODEU, WORK_POSITION_NOU, WORK_POSITION_NAMEU, PATH_NODE_ORDERU, CREATE_TIMEU, UPDATE_TIMEU, ROW_VERSIONU)
     values ( SYS_GUID(),  'r-IN01-R-CR02' ,  '2107' ,  '2107' ,  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());
  
  return '^_^';
  EXCEPTION WHEN OTHERS THEN
    --DBMS_OUTPUT.put_line('SQLCODE = ' || SQLCODE) ;
    --DBMS_OUTPUT.put_line('SQLERRM = ' || SQLERRM) ;
    RAISE;
END;
/

/**/
set serveroutput on;
declare
  v_RightReturn varchar2(20) := '_-1-_';
  v_Temp varchar2(40);
begin
  --dbms_output.put_line(f_A1());
  --dbms_output.put_line(f_A2());
  if ((v_RightReturn != f_A1())AND(v_RightReturn != f_A2())) THEN
	  COMMIT WORK;
  END IF;
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('SQLCODE = ' || SQLCODE) ;
    DBMS_OUTPUT.put_line('SQLERRM = ' || SQLERRM) ;
	ROLLBACK;
	RAISE;
end;
/
drop function f_A1;
drop function f_A2;