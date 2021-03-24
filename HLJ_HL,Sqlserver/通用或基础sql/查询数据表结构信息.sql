/*----��ѯ���е������ֶ�
SELECT
	COLUMN_NAME ����,
	DATA_TYPE ��������,
	DATA_TYPE �ֶ�����,
	CHARACTER_MAXIMUM_LENGTH ����,
	IS_NULLABLE �Ƿ�Ϊ��,
	COLUMN_DEFAULT Ĭ��ֵ
FROM	INFORMATION_SCHEMA.COLUMNS
where (1=1) and	table_name = 'DMT_DataServer';
--*/

--/*----���ĳ�������ֶ�
select * from syscolumns a where
id = (select id from sysobjects where name='DMT_Tag');
--*/

/*
----SQL Server ������ ���ݿ����б������
SELECT a.name AS '��',
  e.name AS '�����ֶ�', a.id, b.Name ������, c.indid, d.colid, e.name
FROM sysobjects AS a          --��������a.xtype='U'���������û���
 LEFT JOIN sysobjects AS b --��������b.xtype='PK'������������Լ��
  ON a.id=b.parent_obj
 LEFT JOIN sysindexes AS c --���������ݣ�������Լ������ƥ�䣬���Ӧ�ֶ�����
  ON a.id=c.id AND b.name=c.name
 LEFT JOIN sysindexkeys AS d --�����ж�Ӧ�����еı���������ƥ�䣬���ֶ�id
  ON a.id=d.id AND c.indid=d.indid
 LEFT JOIN syscolumns AS e --�ֶα������ֶ�idƥ�䣬���ֶ�����
  ON a.id=e.id AND d.colid=e.colid
WHERE a.xtype='U'
  --AND b.xtype='PK'
;

SELECT * FROM SYSOBJECTS;-- WHERE XTYPE='U';--��	xtype='PK'--��	xtype='P'--����		xtype�����ڰ�bai����鵽
SELECT * FROM SYSINDEXES;
SELECT * FROM SYSINDEXKEYS;
SELECT * FROM SYSCOLUMNS;
*/

/*
----- 
select
  a.name as Լ����,
  object_name(b.parent_object_id) as �����,
  d.name as �����,
  object_name(b.referenced_object_id) as ������,
  c.name as ������
  from sys.foreign_keys A
  inner join sys.foreign_key_columns B on A.object_id=b.constraint_object_id
  inner join sys.columns C on B.parent_object_id=C.object_id and B.parent_column_id=C.column_id 
  inner join sys.columns D on B.referenced_object_id=d.object_id and B.referenced_column_id=D.column_id 
  WHERE object_name(b.parent_object_id) LIKE '%DMT_Group%' OR object_name(b.referenced_object_id) LIKE '%DMT_Group%'
;
select * from sys.foreign_keys;
--*/

----���ɽ��á�����ָ�������Լ��
SELECT 'ALTER TABLE '+b.name+' NOCHECK CONSTRAINT '+a.name+';' from sysobjects a, sysobjects b where a.xtype='f' and a.parent_obj=b.id and (b.name='TM_WorkPath' or b.name='TM_WorkPathNode');
SELECT 'ALTER TABLE '+b.name+' CHECK CONSTRAINT '+a.name+';' from sysobjects a, sysobjects b where a.xtype='f' and a.parent_obj=b.id and (b.name='TM_WorkPath' or b.name='TM_WorkPathNode');