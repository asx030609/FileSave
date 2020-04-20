
DELETE FROM "C##FUSION"."EM_ALARM_TYPEU";
DELETE FROM c##fusion.em_equipment_alarmu;
----

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01CR01_SX',  '4000' ,'���X��',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01CR01_SE',  '4000' ,'��ȫֹͣ',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01CR01_PX',  '4000' ,'��λX��',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01CR01_LC1 ',  '4000' ,'Z��������',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01CR01_CA',  '4000' ,'�Ѷ��',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01CR01_BE',  '4000' ,'�����豸',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01BS01_SP',  '4000' ,'���˰�ȫ����',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01BS01_SE',  '4000' ,'��ȫֹͣ',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01BS01_SD ',  '4000' ,'��ȫ������',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01BS01_SB',  '4000' ,'��ȫ�����',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01BS01_CC',  '4000' ,'PLC',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('C01BS01_BE',  '4000' ,'�����豸',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());

insert into "C##FUSION"."EM_ALARM_TYPEU"("ALARM_TYPE_CODEU", "EQUIPMENT_TYPE_CODEU", alarm_type_nameu, activeu, "CREATE_TIMEU", "UPDATE_TIMEU", "ROW_VERSIONU")
values ('A01CR01_SH1',  '4000' ,'1�Ŵ����',  '1' ,  SYSDATE ,  SYSDATE ,  SYS_GUID());





---�豸��Ϣ����
insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0526', '��Ƶ��������Ϣ', 'CR', '�Ѷ��', 'C01CR01_LC1', 'Z��������', 526, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0525', '���˶���ʱ', 'CR', '�Ѷ��', 'C01CR01_LC1', 'Z��������', 525, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0524', '��϶����', 'CR', '�Ѷ��', 'C01CR01_LC1', 'Z��������', 524, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0523', '����ֹͣ', 'CR', '�Ѷ��', 'C01CR01_LC1', 'Z��������', 523, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0522', '����¶ȹ���', 'CR', '�Ѷ��', 'C01CR01_LC1 ', 'Z��������', 522, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0521', '����ԭ��δ����', 'CR', '�Ѷ��', 'C01CR01_LC1 ', 'Z��������', 521, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0496', 'ͨ��ĩ�˵Ĵ����ֹͣ', 'CR', '�Ѷ��', 'C01CR01_SH1', '1�Ŵ����', 496, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0495', 'ͨ��2ĩ�˵Ĵ����ֹͣ', 'CR', '�Ѷ��', 'C01CR01_SH1', '1�Ŵ����', 495, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0494', 'ͨ��1ĩ�˵Ĵ����ֹͣ', 'CR', '�Ѷ��', 'C01CR01_SH1', '1�Ŵ����', 494, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0493', '������ڲ�����IO����ϵͳ/ģ��', 'CR', '�Ѷ��', 'C01CR01_SH1', '1�Ŵ����', 493, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0492', '������ڲ�����DC-DCת����', 'CR', '�Ѷ��', 'C01CR01_SH1', '1�Ŵ����', 492, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0491', '������ڲ�����λ��', 'CR', '�Ѷ��', 'C01CR01_SH1', '1�Ŵ����', 491, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0490', '����������������Ϣ', 'CR', '�Ѷ��', 'C01CR01_SH1', '1�Ŵ����', 490, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0487', '�����δ֪����', 'CR', '�Ѷ��', 'C01CR01_SX', '���X��', 487, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0485', '���������λ�ó�����������', 'CR', '�Ѷ��', 'C01CR01_SX', '���X��', 485, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0484', '�޷���������λ��', 'CR', '�Ѷ��', 'C01CR01_SX', '���X��', 484, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0483', '������ƶ�ʱ��̫��', 'CR', '�Ѷ��', 'C01CR01_SX', '���X��', 483, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0482', '���´��������ֹͣ��ť', 'CR', '�Ѷ��', 'C01CR01_SX', '���X��', 482, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0481', 'ͨ��2ĩ�˵Ĵ����ֹͣ', 'CR', '�Ѷ��', 'C01CR01_SX', '���X��', 481, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0476', '������ȫģ�����ֹͣ(�ٶ�70%)', 'CR', '�Ѷ��', 'C01CR01_SX', '���X��', 476, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0475', '��������ȫģ��(�ٶ� v2)����ֹͣ', 'CR', '�Ѷ��', 'C01CR01_SX', '���X��', 475, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0473', '����ֹͣ��δȷ��', 'CR', '�Ѷ��', 'C01CR01_SX ', '���X��', 473, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0470', '������ȫģ�����ֹͣ(���������70%)', 'CR', '�Ѷ��', 'C01CR01_SX', '���X��', 470, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0469', '����������ȫģ�����ֹͣ(ģ����Ϲ���)', 'CR', '�Ѷ��', 'C01CR01_SX', '���X��', 469, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0398', '��Ƶ������(�����Ƶ����ʾ)', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 398, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0397', '�ƶ�ն��������', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 397, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0396', '�ⲿ���ȹ���', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 396, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0395', '�������ƶ�', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 395, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0394', '����¶ȹ���', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 394, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0393', '����ԭ��δ����', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 393, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0384', '����������', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 384, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0383', '�Ҳ��������', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 383, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0382', '��Ƶ������(�����Ƶ����ʾ)', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 382, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0381', '�ƶ�ն��������', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 381, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0380', '�ⲿ���ȹ���', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 380, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0379', '�������ƶ�', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 379, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0378', '����¶ȹ���', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 378, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0377', '����ԭ��δ����', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 377, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0373', '���ش�������������λ��', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 373, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0372', '����', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 372, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0371', '���ƹ�ƽ̨����', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 371, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0370', '���˶���ʱ', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 370, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0369', '�ﵽ������Χ����', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 369, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0363', 'ʵ��λ����Ч(����������Χ)', 'CR', '�Ѷ��', 'C01CR01_PX  ', '��λX��', 363, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0362', '���������ʵ����������Ч', 'CR', '�Ѷ��', 'C01CR01_PX  ', '��λX��', 362, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0347', '��׼��λ��ʱ', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 347, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0346', 'δ�ҵ���׼��λĿ��', 'CR', '�Ѷ��', 'C01CR01_PX', '��λX��', 346, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0330', '����δ������', 'CR', '�Ѷ��', 'C01CR01_PX ', '��λX��', 330, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0320', '����˿BE_F3��բ', 'CR', '�Ѷ��', 'C01CR01_BE', '�����豸', 320, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0319', '����˿BE_F2��բ', 'CR', '�Ѷ��', 'C01CR01_BE', '�����豸', 319, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0318', '����˿BE_F1��բ', 'CR', '�Ѷ��', 'C01CR01_BE', '�����豸', 318, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0317', '��·��BE_Q4��բ', 'CR', '�Ѷ��', 'C01CR01_BE', '�����豸', 317, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0316', '��·��BE_Q3��բ', 'CR', '�Ѷ��', 'C01CR01_BE', '�����豸', 316, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0315', '��·��BE_Q2��բ', 'CR', '�Ѷ��', 'C01CR01_BE', '�����豸', 315, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0314', '��·��BE_Q1��բ', 'CR', '�Ѷ��', 'C01CR01_BE', '�����豸', 314, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0311', '����˿BE_F10��բ', 'CR', '�Ѷ��', 'C01CR01_BE', '�����豸', 311, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0310', '����˿BE_F9��բ', 'CR', '�Ѷ��', 'C01CR01_BE', '�����豸', 310, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0309', '����˿BE_F8��բ', 'CR', '�Ѷ��', 'C01CR01_BE', '�����豸', 309, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0308', '����˿BE_F7��բ', 'CR', '�Ѷ��', 'C01CR01_BE', '�����豸', 308, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0307', '����˿BE_F6��բ', 'CR', '�Ѷ��', 'C01CR01_BE', '�����豸', 307, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0306', '����˿BE_F5��բ', 'CR', '�Ѷ��', 'C01CR01_BE', '�����豸', 306, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0305', '����˿BE_F4��բ', 'CR', '�Ѷ��', 'C01CR01_BE', '�����豸', 305, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0285', 'AXISX��λ���ؽ���ͣ��', 'CR', '�Ѷ��', 'C01CR01_SE', '��ȫֹͣ', 285, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0284', '���¿�������ϵĽ���ֹͣ��ť', 'CR', '�Ѷ��', 'C01CR01_SE', '��ȫֹͣ', 284, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0283', '��̬���Ź��̵�������ֹͣ', 'CR', '�Ѷ��', 'C01CR01_SE', '��ȫֹͣ', 283, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0282', '�ӿ������������ֹͣ', 'CR', '�Ѷ��', 'C01CR01_SE', '��ȫֹͣ', 282, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0281', '����ֹͣ��δȷ��', 'CR', '�Ѷ��', 'C01CR01_SE', '��ȫֹͣ', 281, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0279', '����ֹͣF-DI/F-DQЭ�����д�ȷ��', 'CR', '�Ѷ��', 'C01CR01_SE', '��ȫֹͣ', 279, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0278', '���Ӵ������������º�բ����', 'CR', '�Ѷ��', 'C01CR01_SE', '��ȫֹͣ', 278, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0234', '���ð�ť����ʱ�����', 'CR', '�Ѷ��', 'C01CR01_CA ', '�Ѷ��', 234, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0218', '���ð�ť����ʱ�����', 'CR', '�Ѷ��', 'C01CR01_CA ', '�Ѷ��', 218, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0202', '���ð�ť����ʱ�����', 'CR', '�Ѷ��', 'C01CR01_CA ', '�Ѷ��', 202, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0176', '���õ�����Ŀ�ĵر�ռ��', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 176, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0175', '��ȡ������Դλ���ǿյ�', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 175, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0174', '���ش�������ڷ���ʱΪ��', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 174, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0173', '���ش�������ڻ�ȡ����ռ��', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 173, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0172', 'CMD������������Ч', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 172, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0171', '��Ч�������趨��', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 171, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0170', '��Ч�������', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 170, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0169', '����ԭ��δ����', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 169, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0167', '�������ȴ��µ������', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 167, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0166', '�ȴ������ź��ٴγ���(���Դ���ϵͳ)', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 166, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0165', '��λ���ɶ���Ŀ��λ��̫��', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 165, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0164', '�޷���������λ��', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 164, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0163', '�������������ģ�����ȷ', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 163, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0162', '���ش���������ƹ���Ԫ����', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 162, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0161', '���������źŶ�ʧ(���Դ���ϵͳ)', 'CR', '�Ѷ��', 'C01CR01_CA', '�Ѷ��', 161, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0154', 'PLC����ϵͳ����(���CPU��ʾ)', 'CR', '�Ѷ��', 'C01BS01_CC', 'PLC', 154, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0096', '����˿BE_F3��բ', 'CR', '�Ѷ��', 'C01BS01_BE', '�����豸', 96, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0095', '����˿BE_F2��բ', 'CR', '�Ѷ��', 'C01BS01_BE', '�����豸', 95, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0094', '����˿BE_F1��բ', 'CR', '�Ѷ��', 'C01BS01_BE', '�����豸', 94, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0093', '��·��BE_Q4��բ', 'CR', '�Ѷ��', 'C01BS01_BE', '�����豸', 93, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0092', '��·��BE_Q3��բ', 'CR', '�Ѷ��', 'C01BS01_BE', '�����豸', 92, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0091', '��·��BE_Q2��բ', 'CR', '�Ѷ��', 'C01BS01_BE', '�����豸', 91, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0090', '��·��BE_Q1��բ', 'CR', '�Ѷ��', 'C01BS01_BE', '�����豸', 90, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0087', '����˿BE_F10��բ', 'CR', '�Ѷ��', 'C01BS01_BE', '�����豸', 87, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0086', '����˿BE_F9��բ', 'CR', '�Ѷ��', 'C01BS01_BE', '�����豸', 86, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0085', '����˿BE_F8��բ', 'CR', '�Ѷ��', 'C01BS01_BE', '�����豸', 85, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0084', '����˿BE_F7��բ', 'CR', '�Ѷ��', 'C01BS01_BE', '�����豸', 84, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

insert into c##fusion.em_equipment_alarmu (alarm_codeu, alarm_descriptionu, equipment_type_codeu, equipment_type_nameu, alarm_type_codeu, alarm_type_nameu, alarm_nou, create_timeu, update_timeu)
values ('CR-0083', '����˿BE_F6��բ', 'CR', '�Ѷ��', 'C01BS01_BE', '�����豸', 83, to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'), to_date('2019/10/20 0:00', 'YYYY/MM/DD HH24:MI'));

commit;
