

--A,升级前，将所有设备都更新为不可用，防止用户呼叫，后面数据难处理
update "C##FUSION"."EM_EQUIPMENTU"
set "ACTIVEU" =  '0' , "REMARKU" =  '' , "UPDATE_TIMEU" = SYSDATE , "ROW_VERSIONU" =  SYS_GUID()
;--where (("EQUIPMENT_CODEU" =  'CR02' ));

--将所有设备启用
update "C##FUSION"."EM_EQUIPMENTU"
set "ACTIVEU" =  '1' , "REMARKU" =  '' , "UPDATE_TIMEU" = SYSDATE , "ROW_VERSIONU" =  SYS_GUID()
;--where (("EQUIPMENT_CODEU" =  'CR02' ));