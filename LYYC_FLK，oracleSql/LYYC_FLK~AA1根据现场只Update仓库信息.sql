


/*
UPDATE TM_WORK_EQUIPMENTU SET WORK_EQUIPMENT_CODEU='CR02' WHERE WORK_EQUIPMENT_CODEU='SRM02';
UPDATE TM_WORK_EQUIPMENTU SET WORK_EQUIPMENT_CODEU='CR01' WHERE WORK_EQUIPMENT_CODEU='SRM01';
commit;
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
          v_Temp := '1'||lpad(iLocationNo, 2, '0')||''||lpad(iLayerNo, 2, '0');
          --/*更新作业位置的X、Y、Z坐标
          update C##FUSION.TM_WORK_POSITIONU
            set "SingleTravelPosition" = iLocationNo, "SingleLiftPosition" = iLayerNo, "SingleForkExtension" =  '0' , "DoubleTravelPosition" =  '0' , "DoubleLiftPosition" =  '0' , "DoubleForkExtension" =  '0' , SERVER_CODEU =  '' , SERVER_NAMEU =  '' , SUPPLY_POSITION_CODEU =  '' , REMARKU =  '' , UPDATE_TIMEU =  SYSDATE , ROW_VERSIONU =  SYS_GUID()
            where ((WORK_POSITION_NOU =  v_Temp ) );
          iLayerNo := iLayerNo + 1;
          EXIT WHEN iLayerNo > 4;
        END LOOP;
        iLayerNo := 1;
        iLocationNo := iLocationNo + 1;
  EXIT WHEN iLocationNo > 32; 
  END LOOP;
  iLocationNo :=1;
  iLayerNo :=1;
  --更新一键生成时，后期更新第3排货架的货位、盘位
  LOOP
        LOOP          
          v_Temp := '2'||lpad(iLocationNo, 2, '0')||''||lpad(iLayerNo, 2, '0');
          --/*更新作业位置的X、Y、Z坐标
          update C##FUSION.TM_WORK_POSITIONU
            set "SingleTravelPosition" = iLocationNo, "SingleLiftPosition" = iLayerNo, "SingleForkExtension" =  '1' , "DoubleTravelPosition" =  '0' , "DoubleLiftPosition" =  '0' , "DoubleForkExtension" =  '0' , SERVER_CODEU =  '' , SERVER_NAMEU =  '' , SUPPLY_POSITION_CODEU =  '' , REMARKU =  '' , UPDATE_TIMEU =  SYSDATE , ROW_VERSIONU =  SYS_GUID()
            where ((WORK_POSITION_NOU =  v_Temp ) );
          iLayerNo := iLayerNo + 1;
          EXIT WHEN iLayerNo > 4;
        END LOOP;
        iLayerNo := 1;
        iLocationNo := iLocationNo + 1;
  EXIT WHEN iLocationNo > 32; 
  END LOOP;
  iLocationNo :=1;
  iLayerNo :=1;
  --更新一键生成时，后期更新第3排货架的货位、盘位
  LOOP
        LOOP          
          v_Temp := '3'||lpad(iLocationNo, 2, '0')||''||lpad(iLayerNo, 2, '0');
          --/*更新作业位置的X、Y、Z坐标
          update C##FUSION.TM_WORK_POSITIONU
            set "SingleTravelPosition" = iLocationNo, "SingleLiftPosition" = iLayerNo, "SingleForkExtension" =  '0' , "DoubleTravelPosition" =  '0' , "DoubleLiftPosition" =  '0' , "DoubleForkExtension" =  '0' , SERVER_CODEU =  '' , SERVER_NAMEU =  '' , SUPPLY_POSITION_CODEU =  '' , REMARKU =  '' , UPDATE_TIMEU =  SYSDATE , ROW_VERSIONU =  SYS_GUID()
            where ((WORK_POSITION_NOU =  v_Temp ) );
          iLayerNo := iLayerNo + 1;
          EXIT WHEN iLayerNo > 4;
        END LOOP;
        iLayerNo := 1;
        iLocationNo := iLocationNo + 1;
  EXIT WHEN iLocationNo > 32; 
  END LOOP;
  iLocationNo :=1;
  iLayerNo :=1;
  --更新一键生成时，后期更新第4排货架的货位、盘位
  LOOP
        LOOP          
          v_Temp := '4'||lpad(iLocationNo, 2, '0')||''||lpad(iLayerNo, 2, '0');
          --/*更新作业位置的X、Y、Z坐标
          update C##FUSION.TM_WORK_POSITIONU
            set "SingleTravelPosition" = iLocationNo, "SingleLiftPosition" = iLayerNo, "SingleForkExtension" =  '1' , "DoubleTravelPosition" =  '0' , "DoubleLiftPosition" =  '0' , "DoubleForkExtension" =  '0' , SERVER_CODEU =  '' , SERVER_NAMEU =  '' , SUPPLY_POSITION_CODEU =  '' , REMARKU =  '' , UPDATE_TIMEU =  SYSDATE , ROW_VERSIONU =  SYS_GUID()
            where ((WORK_POSITION_NOU =  v_Temp ) );
          iLayerNo := iLayerNo + 1;
          EXIT WHEN iLayerNo > 4;
        END LOOP;
        iLayerNo := 1;
        iLocationNo := iLocationNo + 1;
  EXIT WHEN iLocationNo > 32; 
  END LOOP;
  return '^_^';
  EXCEPTION WHEN OTHERS THEN 
    raise;
END;
/
set serveroutput on;
declare
  v_RightReturn varchar2(20) := '_-1-_';
  v_Temp varchar2(40);
begin
  --dbms_output.put_line(f_A1());
  --dbms_output.put_line(f_A2());
  if (v_RightReturn != f_A1()) THEN
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
*/

DELETE FROM TM_WORK_REGIONU WHERE WORK_REGION_CODEU IN ('R-SRM05', 'R-SRM04', 'R-SRM03');
DELETE FROM TM_TASK_DETAILU;
DELETE FROM TM_TASKU;
----删除设备任务
DELETE FROM EM_EQUIPMENT_TASKU;
update TM_OPERATION_EQUIPMENTU set WORK_EQUIPMENT_CODEU='CR01' WHERE WORK_EQUIPMENT_CODEU='SRM01';
UPDATE TM_WORK_EQUIPMENTU SET WORK_EQUIPMENT_CODEU='CR01' WHERE WORK_EQUIPMENT_CODEU='SRM01';
update TM_OPERATION_EQUIPMENTU set WORK_EQUIPMENT_CODEU='CR02' WHERE WORK_EQUIPMENT_CODEU='SRM02';
UPDATE TM_WORK_EQUIPMENTU SET WORK_EQUIPMENT_CODEU='CR02' WHERE WORK_EQUIPMENT_CODEU='SRM02';

update tm_work_positionu  
    set "DoubleTravelPosition" = "SingleTravelPosition",
    "DoubleLiftPosition" = "SingleLiftPosition",
    "DoubleForkExtension" = "SingleForkExtension";
update wm_locationu set Max_pallet_quantityu=1 where  location_nameu like '%01排%';
COMMIT;
select * from TM_WORK_EQUIPMENTU;
select * from TM_OPERATION_EQUIPMENTU;
/