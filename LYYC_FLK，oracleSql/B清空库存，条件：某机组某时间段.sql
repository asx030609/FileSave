
SELECT * FROM WM_PALLETU WHERE IN_FROZEN_QUANTITYU > 0 OR OUT_FROZEN_QUANTITYU > 0 OR STORAGE_SEQUENCEU < 0;
SELECT * FROM WM_PALLETU WHERE LOCATION_CODEU='01-10-01'; 
/
----�ֶ���ָ����ָ������ĶѶ���豸�������ֶ���ָ�ĳ��λ�ã����������������Ѷ���豸���񡣵����������ɰ�ť��ϵͳ����ӽ�һ��ʼ�ͷ���õĻ�λ��Ȼ�������������λ��ֱ�����ݻָ����
----������ֶ��ŵ�������λ�ã�����Ҫ��취����Щ��λ�û�������
----����������ֶ�������ϵķ�ʽ�����ά���á�
----���룬����ԭ��Ӧ���ǣ�������ֶ����Ѷ��ָ����������Ŀ��λ�ã���ôһ������£���Ӧ��

----//������������������ֶ�����������ƿ⡢��ѡ��������ʵ�ʻ���û����������Ҫ����������ⵥ�ݣ������㴴���ĵ��ݣ���ΪҪ����ģ��ɨ�������鷳�������������Ҫ�������ⵥ�ݣ��Ѵ���Ļ�λ��ϵͳ�Ϻ�ʵ����ͨ��������ա�
----//������ֶ��������ⵥ�ݣ�ʵ�ʻ���û��ȥ������ѡ�������Ӧ��λ
create or replace function F_ClearThisPalletInfo(
    V_LOCATION_CODEU varchar2,
    I_STORAGE_SEQUENCEU INTEGER
)
RETURN VARCHAR2
IS
    V_TEMP VARCHAR2(500);
BEGIN

    ----��տ��pallet��Ϣ����Ӧ�㣺����Ϊ6
    UPDATE WM_PALLETU SET MATCH_PALLET_CODEU='', MATCH_PALLET_NAMEU='',UNIQUE_IDU='',PRODUCT_COUNTU=0,STORAGE_QUANTITYU=0,IN_FROZEN_QUANTITYU=0,OUT_FROZEN_QUANTITYU=0
        ,PRODUCT_POSITIONU='',BRAND_CODESU='',BRAND_NAMESU='',PALLET_TYPE_CODEU='',PALLET_TYPE_NAMEU='',STORAGE_SEQUENCEU=0 
        WHERE LOCATION_CODEU=V_LOCATION_CODEU AND UPDATE_TIMEU < (SYSDATE-1);
    --ɾ�������еĿ��Storage��Ϣ
    DELETE FROM WM_STORAGEU WHERE PALLET_IDU IN (SELECT IDU FROM WM_PALLETU WHERE LOCATION_CODEU=V_LOCATION_CODEU  AND UPDATE_TIMEU < (SYSDATE-1));

  return '^_^';
END;
/
SET SERVEROUTPUT ON;
Declare
  ret varchar2(20);
Begin
  dbms_output.put_line('����ֵ��'||F_ClearThisPalletInfo('203002',2));
  COMMIT WORK;
EXCEPTION
WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
