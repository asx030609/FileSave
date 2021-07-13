
/*--*********************************
select  s.*  
from  ( 
     select  *, row_number() over (partition  by  [手机号]  order  by  [店铺])  as  group_idx  
     from  table_name
) s
where  s.group_idx = 1
--*/
----*********************************
--取各一条数据
select  s.*  
from  ( 
     select  *, row_number() over (partition  by  ProductCode  order  by ProductCode) as  group_idx  
     from  BI_ProductUnit
) s
where  s.group_idx = 1
order by s.ProductCode;

----取重复数据中的第二条
select  s.*  
from  ( 
     select  *, row_number() over (partition  by  ProductCode  order  by ProductCode) as  group_idx  
     from  TB01
) s
where  s.group_idx = 2
order by s.ProductCode;