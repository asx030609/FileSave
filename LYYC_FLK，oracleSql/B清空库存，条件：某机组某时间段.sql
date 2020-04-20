
SELECT * FROM WM_PALLETU WHERE IN_FROZEN_QUANTITYU > 0 OR OUT_FROZEN_QUANTITYU > 0 OR STORAGE_SEQUENCEU < 0;
SELECT * FROM WM_PALLETU WHERE LOCATION_CODEU='01-10-01'; 
/
----手动发指令是指将错误的堆垛机设备任务用手动发指令到某个位置，这样就完成了这个堆垛机设备任务。但点击任务完成按钮，系统会添加进一开始就分配好的货位。然后禁用这两个货位，直到数据恢复完成
----如果是手动放到了其他位置，后面要想办法将这些个位置换回来。
----而后可以用手动入库物料的方式将库存维护好。
----想想，处理原则应该是，如果是手动发堆垛机指令改了任务的目标位置，那么一般情况下，是应该

----//总体上来讲，如果是手动任务完成了移库、拣选出库任务，实际货物没出来，则需要创建验收入库单据，如果随便创建的单据（因为要数据模拟扫码入库很麻烦），则后面再需要创建出库单据，把错误的货位在系统上和实际上通过任务清空。
----//如果是手动完成了入库单据，实际货物没进去，可以选择清空相应盘位
create or replace function F_ClearThisPalletInfo(
    V_LOCATION_CODEU varchar2,
    I_STORAGE_SEQUENCEU INTEGER
)
RETURN VARCHAR2
IS
    V_TEMP VARCHAR2(500);
BEGIN

    ----清空库存pallet信息，对应点：长度为6
    UPDATE WM_PALLETU SET MATCH_PALLET_CODEU='', MATCH_PALLET_NAMEU='',UNIQUE_IDU='',PRODUCT_COUNTU=0,STORAGE_QUANTITYU=0,IN_FROZEN_QUANTITYU=0,OUT_FROZEN_QUANTITYU=0
        ,PRODUCT_POSITIONU='',BRAND_CODESU='',BRAND_NAMESU='',PALLET_TYPE_CODEU='',PALLET_TYPE_NAMEU='',STORAGE_SEQUENCEU=0 
        WHERE LOCATION_CODEU=V_LOCATION_CODEU AND UPDATE_TIMEU < (SYSDATE-1);
    --删除机组中的库存Storage信息
    DELETE FROM WM_STORAGEU WHERE PALLET_IDU IN (SELECT IDU FROM WM_PALLETU WHERE LOCATION_CODEU=V_LOCATION_CODEU  AND UPDATE_TIMEU < (SYSDATE-1));

  return '^_^';
END;
/
SET SERVEROUTPUT ON;
Declare
  ret varchar2(20);
Begin
  dbms_output.put_line('返回值：'||F_ClearThisPalletInfo('203002',2));
  COMMIT WORK;
EXCEPTION
WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
