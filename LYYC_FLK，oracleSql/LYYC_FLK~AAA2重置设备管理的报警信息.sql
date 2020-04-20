
DELETE FROM "C##FUSION"."EM_ALARM_TYPEU";
DELETE FROM c##fusion.em_equipment_alarmu;
----

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01CR01_SX',  '4000' ,'监控X轴',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01CR01_SE',  '4000' ,'安全停止',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01CR01_PX',  '4000' ,'定位X轴',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01CR01_LC1 ',  '4000' ,'Z轴链传动',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01CR01_CA',  '4000' ,'堆垛机',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01CR01_BE',  '4000' ,'基础设备',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01BS01_SP',  '4000' ,'个人安全保护',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01BS01_SE',  '4000' ,'安全停止',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01BS01_SD ',  '4000' ,'安全逃生门',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01BS01_SB',  '4000' ,'安全光壁垒',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01BS01_CC',  '4000' ,'PLC',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01BS01_BE',  '4000' ,'基本设备',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('A01CR01_SH1',  '4000' ,'1号穿梭板',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());





---设备信息编码
insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0526', '变频器故障信息', 'CR', '堆垛机', 'C01CR01_LC1', 'Z轴链传动', 526, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0525', '轴运动超时', 'CR', '堆垛机', 'C01CR01_LC1', 'Z轴链传动', 525, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0524', '间隙控制', 'CR', '堆垛机', 'C01CR01_LC1', 'Z轴链传动', 524, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0523', '紧急停止', 'CR', '堆垛机', 'C01CR01_LC1', 'Z轴链传动', 523, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0522', '电机温度过高', 'CR', '堆垛机', 'C01CR01_LC1 ', 'Z轴链传动', 522, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0521', '故障原因未消除', 'CR', '堆垛机', 'C01CR01_LC1 ', 'Z轴链传动', 521, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0496', '通道末端的穿梭机停止', 'CR', '堆垛机', 'C01CR01_SH1', '1号穿梭板', 496, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0495', '通道2末端的穿梭机停止', 'CR', '堆垛机', 'C01CR01_SH1', '1号穿梭板', 495, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0494', '通道1末端的穿梭机停止', 'CR', '堆垛机', 'C01CR01_SH1', '1号穿梭板', 494, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0493', '穿梭机内部错误IO总线系统/模块', 'CR', '堆垛机', 'C01CR01_SH1', '1号穿梭板', 493, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0492', '穿梭机内部错误DC-DC转换器', 'CR', '堆垛机', 'C01CR01_SH1', '1号穿梭板', 492, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0491', '穿梭机内部错误定位块', 'CR', '堆垛机', 'C01CR01_SH1', '1号穿梭板', 491, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0490', '穿梭逆向器故障信息', 'CR', '堆垛机', 'C01CR01_SH1', '1号穿梭板', 490, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0487', '穿梭机未知错误', 'CR', '堆垛机', 'C01CR01_SX', '监控X轴', 487, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0485', '穿梭机设置位置超出操作区域', 'CR', '堆垛机', 'C01CR01_SX', '监控X轴', 485, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0484', '无法到达梭心位置', 'CR', '堆垛机', 'C01CR01_SX', '监控X轴', 484, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0483', '穿梭机移动时间太长', 'CR', '堆垛机', 'C01CR01_SX', '监控X轴', 483, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0482', '按下穿梭机紧急停止按钮', 'CR', '堆垛机', 'C01CR01_SX', '监控X轴', 482, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0481', '通道2末端的穿梭机停止', 'CR', '堆垛机', 'C01CR01_SX', '监控X轴', 481, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0476', '驱动安全模块紧急停止(速度70%)', 'CR', '堆垛机', 'C01CR01_SX', '监控X轴', 476, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0475', '从驱动安全模块(速度 v2)紧急停止', 'CR', '堆垛机', 'C01CR01_SX', '监控X轴', 475, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0473', '紧急停止尚未确认', 'CR', '堆垛机', 'C01CR01_SX ', '监控X轴', 473, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0470', '驱动安全模块紧急停止(传感器检查70%)', 'CR', '堆垛机', 'C01CR01_SX', '监控X轴', 470, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0469', '从驱动器安全模块紧急停止(模块故障功能)', 'CR', '堆垛机', 'C01CR01_SX', '监控X轴', 469, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0398', '变频器故障(详见变频器显示)', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 398, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0397', '制动斩波器过流', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 397, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0396', '外部风扇故障', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 396, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0395', '不允许移动', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 395, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0394', '电机温度过高', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 394, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0393', '故障原因未消除', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 393, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0384', '左侧轮廓误差', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 384, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0383', '右侧轮廓误差', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 383, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0382', '变频器故障(详见变频器显示)', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 382, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0381', '制动斩波器过流', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 381, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0380', '外部风扇故障', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 380, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0379', '不允许移动', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 379, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0378', '电机温度过高', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 378, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0377', '故障原因未消除', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 377, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0373', '负载处理器不在中心位置', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 373, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0372', '超载', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 372, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0371', '控制柜平台拉出', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 371, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0370', '轴运动超时', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 370, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0369', '达到工作范围结束', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 369, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0363', '实际位置无效(超出工作范围)', 'CR', '堆垛机', 'C01CR01_PX  ', '定位X轴', 363, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0362', '换层区域的实际连接线无效', 'CR', '堆垛机', 'C01CR01_PX  ', '定位X轴', 362, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0347', '精准定位超时', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 347, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0346', '未找到精准定位目标', 'CR', '堆垛机', 'C01CR01_PX', '定位X轴', 346, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0330', '轴尚未被引用', 'CR', '堆垛机', 'C01CR01_PX ', '定位X轴', 330, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0320', '保险丝BE_F3跳闸', 'CR', '堆垛机', 'C01CR01_BE', '基础设备', 320, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0319', '保险丝BE_F2跳闸', 'CR', '堆垛机', 'C01CR01_BE', '基础设备', 319, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0318', '保险丝BE_F1跳闸', 'CR', '堆垛机', 'C01CR01_BE', '基础设备', 318, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0317', '断路器BE_Q4跳闸', 'CR', '堆垛机', 'C01CR01_BE', '基础设备', 317, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0316', '断路器BE_Q3跳闸', 'CR', '堆垛机', 'C01CR01_BE', '基础设备', 316, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0315', '断路器BE_Q2跳闸', 'CR', '堆垛机', 'C01CR01_BE', '基础设备', 315, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0314', '断路器BE_Q1跳闸', 'CR', '堆垛机', 'C01CR01_BE', '基础设备', 314, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0311', '保险丝BE_F10跳闸', 'CR', '堆垛机', 'C01CR01_BE', '基础设备', 311, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0310', '保险丝BE_F9跳闸', 'CR', '堆垛机', 'C01CR01_BE', '基础设备', 310, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0309', '保险丝BE_F8跳闸', 'CR', '堆垛机', 'C01CR01_BE', '基础设备', 309, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0308', '保险丝BE_F7跳闸', 'CR', '堆垛机', 'C01CR01_BE', '基础设备', 308, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0307', '保险丝BE_F6跳闸', 'CR', '堆垛机', 'C01CR01_BE', '基础设备', 307, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0306', '保险丝BE_F5跳闸', 'CR', '堆垛机', 'C01CR01_BE', '基础设备', 306, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0305', '保险丝BE_F4跳闸', 'CR', '堆垛机', 'C01CR01_BE', '基础设备', 305, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0285', 'AXISX限位开关紧急停车', 'CR', '堆垛机', 'C01CR01_SE', '安全停止', 285, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0284', '按下控制面板上的紧急停止按钮', 'CR', '堆垛机', 'C01CR01_SE', '安全停止', 284, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0283', '动态看门狗继电器紧急停止', 'CR', '堆垛机', 'C01CR01_SE', '安全停止', 283, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0282', '从控制器软件紧急停止', 'CR', '堆垛机', 'C01CR01_SE', '安全停止', 282, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0281', '紧急停止尚未确认', 'CR', '堆垛机', 'C01CR01_SE', '安全停止', 281, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0279', '紧急停止F-DI/F-DQ协助仍有待确认', 'CR', '堆垛机', 'C01CR01_SE', '安全停止', 279, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0278', '主接触器反馈错误导致合闸闭锁', 'CR', '堆垛机', 'C01CR01_SE', '安全停止', 278, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0234', '启用按钮按下时间过长', 'CR', '堆垛机', 'C01CR01_CA ', '堆垛机', 234, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0218', '启用按钮按下时间过长', 'CR', '堆垛机', 'C01CR01_CA ', '堆垛机', 218, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0202', '启用按钮按下时间过长', 'CR', '堆垛机', 'C01CR01_CA ', '堆垛机', 202, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0176', '放置的物理目的地被占用', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 176, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0175', '获取的物理源位置是空的', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 175, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0174', '加载处理程序在放置时为空', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 174, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0173', '加载处理程序在获取处被占用', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 173, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0172', 'CMD函数的条件无效', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 172, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0171', '无效的命令设定点', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 171, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0170', '无效的命令函数', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 170, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0169', '故障原因未消除', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 169, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0167', '错误处理后等待新的命令函数', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 167, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0166', '等待启用信号再次出现(来自传送系统)', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 166, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0165', '单位负荷对于目标位置太高', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 165, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0164', '无法到达多个深位置', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 164, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0163', '传输结束是物理的，不正确', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 163, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0162', '加载处理程序已推过单元加载', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 162, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0161', '传送启用信号丢失(来自传送系统)', 'CR', '堆垛机', 'C01CR01_CA', '堆垛机', 161, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0154', 'PLC报告系统故障(详见CPU显示)', 'CR', '堆垛机', 'C01BS01_CC', 'PLC', 154, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0096', '保险丝BE_F3跳闸', 'CR', '堆垛机', 'C01BS01_BE', '基本设备', 96, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0095', '保险丝BE_F2跳闸', 'CR', '堆垛机', 'C01BS01_BE', '基本设备', 95, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0094', '保险丝BE_F1跳闸', 'CR', '堆垛机', 'C01BS01_BE', '基本设备', 94, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0093', '断路器BE_Q4跳闸', 'CR', '堆垛机', 'C01BS01_BE', '基本设备', 93, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0092', '断路器BE_Q3跳闸', 'CR', '堆垛机', 'C01BS01_BE', '基本设备', 92, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0091', '断路器BE_Q2跳闸', 'CR', '堆垛机', 'C01BS01_BE', '基本设备', 91, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0090', '断路器BE_Q1跳闸', 'CR', '堆垛机', 'C01BS01_BE', '基本设备', 90, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0087', '保险丝BE_F10跳闸', 'CR', '堆垛机', 'C01BS01_BE', '基本设备', 87, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0086', '保险丝BE_F9跳闸', 'CR', '堆垛机', 'C01BS01_BE', '基本设备', 86, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0085', '保险丝BE_F8跳闸', 'CR', '堆垛机', 'C01BS01_BE', '基本设备', 85, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0084', '保险丝BE_F7跳闸', 'CR', '堆垛机', 'C01BS01_BE', '基本设备', 84, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0083', '保险丝BE_F6跳闸', 'CR', '堆垛机', 'C01BS01_BE', '基本设备', 83, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

commit;
