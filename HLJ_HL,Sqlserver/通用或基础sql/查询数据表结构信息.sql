/*----查询表单中的所有字段
SELECT
	COLUMN_NAME 列名,
	DATA_TYPE 数据类型,
	DATA_TYPE 字段类型,
	CHARACTER_MAXIMUM_LENGTH 长度,
	IS_NULLABLE 是否为空,
	COLUMN_DEFAULT 默认值
FROM	INFORMATION_SCHEMA.COLUMNS
where (1=1) and	table_name = 'DMT_DataServer';
--*/

--/*----查出某表所有字段
select * from syscolumns a where
id = (select id from sysobjects where name='DMT_Tag');
--*/

/*
----SQL Server 批量查 数据库所有表的主键
SELECT a.name AS '表',
  e.name AS '主键字段', a.id, b.Name 主键名, c.indid, d.colid, e.name
FROM sysobjects AS a          --对象表，结合a.xtype='U'条件，查用户表
 LEFT JOIN sysobjects AS b --对象表，结合b.xtype='PK'条件，查主键约束
  ON a.id=b.parent_obj
 LEFT JOIN sysindexes AS c --索引表，根据（主键）约束名称匹配，查对应字段索引
  ON a.id=c.id AND b.name=c.name
 LEFT JOIN sysindexkeys AS d --索引中对应键、列的表，根据索引匹配，查字段id
  ON a.id=d.id AND c.indid=d.indid
 LEFT JOIN syscolumns AS e --字段表，根据字段id匹配，查字段名称
  ON a.id=e.id AND d.colid=e.colid
WHERE a.xtype='U'
  --AND b.xtype='PK'
;

SELECT * FROM SYSOBJECTS;-- WHERE XTYPE='U';--表	xtype='PK'--键	xtype='P'--过程		xtype可以在帮bai助里查到
SELECT * FROM SYSINDEXES;
SELECT * FROM SYSINDEXKEYS;
SELECT * FROM SYSCOLUMNS;
*/

/*
----- 
select
  a.name as 约束名,
  object_name(b.parent_object_id) as 外键表,
  d.name as 外键列,
  object_name(b.referenced_object_id) as 主健表,
  c.name as 主键列
  from sys.foreign_keys A
  inner join sys.foreign_key_columns B on A.object_id=b.constraint_object_id
  inner join sys.columns C on B.parent_object_id=C.object_id and B.parent_column_id=C.column_id 
  inner join sys.columns D on B.referenced_object_id=d.object_id and B.referenced_column_id=D.column_id 
  WHERE object_name(b.parent_object_id) LIKE '%DMT_Group%' OR object_name(b.referenced_object_id) LIKE '%DMT_Group%'
;
select * from sys.foreign_keys;
--*/

----生成禁用、开启指定表外键约束
SELECT 'ALTER TABLE '+b.name+' NOCHECK CONSTRAINT '+a.name+';' from sysobjects a, sysobjects b where a.xtype='f' and a.parent_obj=b.id and (b.name='TM_WorkPath' or b.name='TM_WorkPathNode');
SELECT 'ALTER TABLE '+b.name+' CHECK CONSTRAINT '+a.name+';' from sysobjects a, sysobjects b where a.xtype='f' and a.parent_obj=b.id and (b.name='TM_WorkPath' or b.name='TM_WorkPathNode');