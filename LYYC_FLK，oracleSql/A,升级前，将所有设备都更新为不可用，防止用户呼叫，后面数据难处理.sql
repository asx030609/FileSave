

--A,����ǰ���������豸������Ϊ�����ã���ֹ�û����У����������Ѵ���
update "C##FUSION"."EM_EQUIPMENTU"
set "ACTIVEU" =  '0' , "REMARKU" =  '' , "UPDATE_TIMEU" = SYSDATE , "ROW_VERSIONU" =  SYS_GUID()
;--where (("EQUIPMENT_CODEU" =  'CR02' ));

--�������豸����
update "C##FUSION"."EM_EQUIPMENTU"
set "ACTIVEU" =  '1' , "REMARKU" =  '' , "UPDATE_TIMEU" = SYSDATE , "ROW_VERSIONU" =  SYS_GUID()
;--where (("EQUIPMENT_CODEU" =  'CR02' ));