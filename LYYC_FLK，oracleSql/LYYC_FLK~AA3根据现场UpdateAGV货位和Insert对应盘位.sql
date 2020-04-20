
CREATE OR REPLACE PROCEDURE PRO_1
IS
    V_LOCATION_CODE VARCHAR2(50);
    V_EXIST_ROWNUM NUMBER(3);
BEGIN
    --卷接机组的货位信息Update和Insert
    FOR V_JIZUHAO IN 1 .. 8 LOOP
            
        FOR V_PANHAO IN 1 .. 5 LOOP    
        
            V_LOCATION_CODE := '1' || lpad(V_JIZUHAO,2,'0') || lpad(V_PANHAO,3,'0');
            DBMS_OUTPUT.PUT_LINE('机组编号为：'||V_LOCATION_CODE);
    
            update "C##FUSION"."WM_LOCATIONU"
                set "LOCATION_TYPEU" =  '2' , "PRESET_PRODUCT_CODEU" =  '' , "PRESET_PRODUCT_NAMEU" =  '' , "MAX_PALLET_QUANTITYU" =  '100' , "LOCATION_RFIDU" =  '' , "FRONT_EQUIPMENT_CODESU" =  ''
                , "REAR_EQUIPMENT_CODESU" =  '' , "REMARKU" =  '' , "UPDATE_TIMEU" =  SYSDATE , "ROW_VERSIONU" =  SYS_GUID()
                where ("LOCATION_CODEU" = V_LOCATION_CODE );    

            SELECT COUNT(*) INTO V_EXIST_ROWNUM FROM "C##FUSION"."WM_PALLETU" WHERE LOCATION_CODEU = V_LOCATION_CODE;
            IF V_EXIST_ROWNUM < 0 THEN
                DBMS_OUTPUT.PUT_LINE('已有行号：'||V_EXIST_ROWNUM);
            ELSE
                FOR V_INSERT_ROWNUM IN 1 .. (30 - V_EXIST_ROWNUM) LOOP
                    DBMS_OUTPUT.PUT_LINE('还需添加Pallet行数：'||(100 - V_EXIST_ROWNUM)||'后期已添加行数'||V_INSERT_ROWNUM);        
                    insert into "C##FUSION"."WM_PALLETU"("IDU", "LOCATION_CODEU", "PALLET_NAMEU", "MATCH_PALLET_CODEU", "MATCH_PALLET_NAMEU", "UNIQUE_IDU", "PRODUCT_COUNTU", "STORAGE_QUANTITYU"
                        , "IN_FROZEN_QUANTITYU", "OUT_FROZEN_QUANTITYU", "STORAGE_SEQUENCEU", "PRODUCT_POSITIONU", "BRAND_CODESU", "BRAND_NAMESU", "PALLET_TYPE_CODEU", "PALLET_TYPE_NAMEU", "PALLET_NOU", "INBOUND_POSITION_NOU", "OUTBOUND_POSITION_NOU", "RESERVEU", "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
                        values ( SYS_GUID(),  V_LOCATION_CODE ,  '盘位'||(V_INSERT_ROWNUM + V_EXIST_ROWNUM) ,  '' ,  '' , null,  '0' ,  '0' ,  '0' ,  '0' ,  (V_INSERT_ROWNUM + V_EXIST_ROWNUM) 
                        , '0',  '' ,  '' ,  '' ,  '' ,  '0' ,  '0' ,  '0' , null,  SYSDATE ,  SYSDATE ,  SYS_GUID());   
                
                END LOOP;
            END IF;
        END LOOP;
    END LOOP;
    
    --封装机组的货位信息更新
END;
/
SET SERVEROUTPUT ON;
EXEC PRO_1;