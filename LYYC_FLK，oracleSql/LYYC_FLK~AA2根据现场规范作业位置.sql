/*
必须先手工删除原先插入过的非高架库虚拟货位以及货位对应的盘位、作业位置以及作业绑定的设备
insert into "C##FUSION"."WM_REGIONU"("WAREHOUSE_CODEU", "REGION_CODEU", "REGION_NAMEU", "DISPLAY_ORDERU", "REGION_TYPEU", "ALLOT_IN_ORDERU", "ALLOT_OUT_ORDERU", "ACTIVEU", "EXTERNAL_REGION_CODEU", "REMARKU", "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
    values ( 'w002' ,  'w002r02' ,  '其他区' ,  '2' ,  '10' ,  '0' ,  '0' ,  '1' ,  '' ,  '' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());
insert into "C##FUSION"."WM_SHELFU"("WAREHOUSE_CODEU", "REGION_CODEU", "SHELF_CODEU", "SHELF_NAMEU", "DISPLAY_ORDERU", "ACTIVEU", "REMARKU", "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
    values ( 'w002' ,  'w002r02' ,  'w002r02-01' ,  '其他' ,  '1' ,  '1' ,  '' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());
--*/


create or replace function f_A1
RETURN VARCHAR2
is
  v_AGVPositionCodeList varchar2(1000) := '';
  v_InBoundPositionCodeList varchar2(500) := '';
  v_OutBoundPositionCodeList varchar2(500) := '';
  v_CR01PositionCodeList varchar2(500) := '';
  v_CR02PositionCodeList varchar2(500) := '';
  v_AGVPositionNameList varchar2(1000) := '';
  v_InBoundPositionNameList varchar2(500) := '';
  v_OutBoundPositionNameList varchar2(500) := '';
  v_CR01PositionNameList varchar2(500) := '';
  v_CR02PositionNameList varchar2(500) := '';
  v_positionCode varchar2(30);
  v_positionName varchar2(100);
  i_postions_ordernum INTEGER := 140;
  v_workRegionCode varchar2(30);
  v_workRegionName varchar2(30);
  v_operEquipCode varchar2(50);
  v_operEquipName varchar2(50);
  totalPositionCodeNum INTEGER;
  tempExistedRowNum INTEGER;
  v_Temp varchar2(1500);
  v_Temp1 varchar2(1500);
BEGIN
  ----插入需要和AGV交互的作业位置和货位、盘位
  v_AGVPositionCodeList := '101001,101002,101003,101004,101005,102001,102002,102003,102004,102005,103001,103002,103003,103004,103005,104001,104002,104003,104004'||
    ',104005,105001,105002,105003,105004,105005,106001,106002,106003,106004,106005,107001,107002,107003,107004,107005,108001,108002,108003,108004,108005'||
    ',202001,202002,203001,203002,204001,204002';
  v_InBoundPositionCodeList := '2101,2112';
  v_CR01PositionCodeList := '2104,2110,2229,2205';
  v_CR02PositionCodeList := '2108,2107,2201,2219';
  v_OutBoundPositionCodeList := '2213,2226,2210,2211';
  v_AGVPositionNameList := '101001,101002,101003,101004,101005,102001,102002,102003,102004,102005,103001,103002,103003,103004,103005,104001,104002,104003,104004'||
    ',104005,105001,105002,105003,105004,105005,106001,106002,106003,106004,106005,107001,107002,107003,107004,107005,108001,108002,108003,108004,108005'||
    ',202001,202002,203001,203002,204001,204002';
  v_InBoundPositionNameList := '辅料入库,入库、抽检、盘点、退库';
  v_CR01PositionNameList := '1号堆垛机西北站台,1号堆垛机东北站台,1号堆垛机西南站台,1号堆垛机东南站台';
  v_CR02PositionNameList := '2号堆垛机西北站台,2号堆垛机东北站台,2号堆垛机西南站台,2号堆垛机东南站台';
  v_OutBoundPositionNameList := '码盘机,实托盘出库(西),实托盘出库(东),空托盘、余料回库';
  FOR iType IN 0 .. 5 LOOP
      if (iType = 0) THEN
          continue;
          ----插入AGV运行所需数据，包含作业位置、操作设备、虚拟货位、对应盘位
          v_Temp := v_AGVPositionCodeList;
          v_Temp1 := v_AGVPositionNameList;
          ----插入作业区域
          v_workRegionCode := 'R-AGV';
          v_workRegionName := 'R-AGV';
          ----已添加
          ----添加作业所需设备
          v_operEquipCode := 'AGV';
          v_operEquipName := 'AGV';
          select WORK_EQUIPMENT_NAMEU into v_operEquipName from C##FUSION.TM_WORK_EQUIPMENTU where WORK_EQUIPMENT_CODEU=v_operEquipCode;
      elsif(iType=1) THEN
          continue;
          v_Temp := v_InBoundPositionCodeList;
          v_Temp1 := v_InBoundPositionNameList;
          ----插入作业区域
          v_workRegionCode := 'R-InBound';
          v_workRegionName := '';
          ----已添加
          ----添加作业所需设备
          v_operEquipCode := ' ';
          v_operEquipName := '';
      elsif (iType = 2) THEN
          continue;
          v_Temp := v_CR01PositionCodeList;
          v_Temp1 := v_CR01PositionNameList;
          ----插入作业区域
          v_workRegionCode := 'R-CR01';
          v_workRegionName := '';
          ----已添加
          ----添加作业所需设备
          v_operEquipCode := 'CR01';
          v_operEquipName := '';
          --^_^已经一键生成过，所以直接使用^_^
          select WORK_EQUIPMENT_NAMEU into v_operEquipName from C##FUSION.TM_WORK_EQUIPMENTU where WORK_EQUIPMENT_CODEU=v_operEquipCode;
      elsif (iType = 3) THEN
          continue;
          v_Temp := v_CR02PositionCodeList;
          v_Temp1 := v_CR02PositionNameList;
          ----插入作业区域
          v_workRegionCode := 'R-CR02';
          v_workRegionName := '';
          ----已添加
          ----添加作业所需设备
          v_operEquipCode := 'CR02';
          v_operEquipName := '';
          --^_^已经一键生成过，所以直接使用^_^
          select WORK_EQUIPMENT_NAMEU into v_operEquipName from C##FUSION.TM_WORK_EQUIPMENTU where WORK_EQUIPMENT_CODEU=v_operEquipCode;
      elsif (iType = 4) THEN
          v_Temp := v_OutBoundPositionCodeList;
          v_Temp1 := v_OutBoundPositionNameList;
          ----插入作业区域
          v_workRegionCode := 'R-OutBound';
          v_workRegionName := '';
          ----已添加
          ----添加作业所需设备
          v_operEquipCode := ' ';
          v_operEquipName := '';
      else
          continue;
      END IF;
      i_postions_ordernum := 1;
      totalPositionCodeNum := Length(v_Temp)/4;
      FOR i IN 0 .. totalPositionCodeNum-1 LOOP
        v_positionCode := Get_StrArrayStrOfIndex(v_Temp, ',', i);
        v_positionName := Get_StrArrayStrOfIndex(v_Temp1, ',', i);
        if (v_positionCode != ' ') then
          ----插入作业位置对应的虚拟货位
          --DBMS_OUTPUT.put_line('v_positionCode = ' || v_positionCode) ;
          Insert into C##FUSION.WM_LOCATIONU (LOCATION_CODEU,LOCATION_NAMEU,LOCATION_TYPEU,WAREHOUSE_CODEU,REGION_CODEU,SHELF_CODEU,PRESET_PRODUCT_CODEU,PRESET_PRODUCT_NAMEU,IN_POSITION_NOU,OUT_POSITION_NOU,IN_WORK_EQUIPMENT_CODESU,OUT_WORK_EQUIPMENT_CODESU,PALLET_MAX_RESERVESU,MAX_PALLET_QUANTITYU,OUT_STRATEGYU,OUT_ALLOT_STRATEGYU,DISPLAY_ORDERU,ALLOT_IN_ORDERU,LOCATION_RFIDU,LOCATION_LAYERU,LOCATION_COLUMNU,COORDINATE_XU,COORDINATE_YU,LOCATION_STATUSU,FRONT_POSITIONU,REAR_POSITIONU,LOCK_TAGU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
            (v_positionCode,v_positionName,0,'w002','w002r02','w002r02-01',null,null,v_positionCode,v_positionCode,v_operEquipCode,v_operEquipCode,30,1,0,0,i_postions_ordernum,0,null,1,1,0,0,1,0,0,null,null,sysdate,sysdate,SYS_GUID());
          ----插入作业位置--
          Insert into C##FUSION.TM_WORK_POSITIONU (WORK_POSITION_NOU,WORK_POSITION_NAMEU,POSITION_TYPEU,WORK_REGION_CODEU,"SingleTravelPosition","SingleLiftPosition","SingleForkExtension","DoubleTravelPosition","DoubleLiftPosition","DoubleForkExtension",ABLE_STOCK_OUTU,ABLE_STOCK_IN_PALLETU,HAS_GET_REQUESTU,HAS_PUT_REQUESTU,SERVER_CODEU,SERVER_NAMEU,SUPPLY_POSITION_CODEU,CACHE_CAPACITYU,CACHED_QUANTITYU,POSITION_CAPACITYU,USED_QUANTITYU,ACTIVEU,REMARKU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
            (v_positionCode,v_positionName,0,v_workRegionCode,0,0,0,0,0,0,1,1,1,1,null,null,null,0,0,0,0,1,null,sysdate,sysdate,SYS_GUID());
          ----插入盘位
          INSERT INTO C##FUSION.WM_PALLETU (IDU,LOCATION_CODEU,PALLET_NAMEU,MATCH_PALLET_CODEU,MATCH_PALLET_NAMEU,UNIQUE_IDU,PRODUCT_COUNTU,STORAGE_QUANTITYU,IN_FROZEN_QUANTITYU,OUT_FROZEN_QUANTITYU,STORAGE_SEQUENCEU,PRODUCT_POSITIONU,BRAND_CODESU,BRAND_NAMESU,PALLET_TYPE_CODEU,PALLET_TYPE_NAMEU,PALLET_NOU,INBOUND_POSITION_NOU,OUTBOUND_POSITION_NOU,RESERVEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
            (SYS_GUID(),v_positionCode,'盘位',null,null,null,0,0,0,0,0,null,null,null,null,null,0,0,0,null,sysdate,sysdate,SYS_GUID());
          --插入作业路径上使用的设备
          IF v_operEquipCode = ' ' then
            continue;
          else
            Insert into C##FUSION.TM_OPERATION_EQUIPMENTU (IDU,WORK_POSITION_NOU,WORK_EQUIPMENT_CODEU,WORK_EQUIPMENT_NAMEU,CREATE_TIMEU,UPDATE_TIMEU,ROW_VERSIONU) values 
              (SYS_GUID(),v_positionCode,v_operEquipCode,v_operEquipName,SYSDATE,SYSDATE,SYS_GUID());
          END IF;
        end if;
      END LOOP;
  END LOOP;
  
	----插入作业路径
	--插入作业路径
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
  v_RightReturn varchar2(20) := '^_^';
  v_Temp varchar2(40);
begin
  --dbms_output.put_line(f_A2());
  if ((v_RightReturn = f_A1())) THEN
      dbms_output.put_line(v_RightReturn);
	    COMMIT WORK;
  END IF;
  ROLLBACK;
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('SQLCODE = ' || SQLCODE) ;
    DBMS_OUTPUT.put_line('SQLERRM = ' || SQLERRM) ;
	ROLLBACK;
	RAISE;
end;
/
drop function f_A1;