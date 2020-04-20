
----查询某表的所有索引
SELECT 
 b.uniqueness, a.index_name, a.table_name, a.column_name
FROM all_ind_columns a, all_indexes b
where a.index_name = b.index_name 
    --or a.index_name like '%PK_EM_EQUIPMENT_TASKU%'
    and a.table_name like upper('%WM_MACHINE_CALLU%') -- in (upper('EM_EQUIPMENT_TASKU'), upper('EM_SUB_EQUIPMENTU'))
ORDER BY a.table_name, a.index_name, a.column_position;
--
------查询数据库的table
--select * from tab;
--select * from cat;
--select TABLE_NAME FROM user_tables;

----查询含某字段的所有表
select count(table_name) from
  user_tab_cols where column_name = 'CURRENT_TASK_COUNTU' and table_name like '%TM_WORK_EQUIPMENTU%';
  
--select * from USER_TABS;
SELECT * FROM USER_TAB_COLS WHERE TABLE_NAME LIKE '%Parameter%';