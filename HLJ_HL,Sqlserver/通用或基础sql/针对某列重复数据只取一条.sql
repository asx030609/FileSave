select  s.*  
from  ( 
     select  *, row_number() over (partition  by  [手机号]  order  by  [店铺])  as  group_idx  
     from  table_name
) s
where  s.group_idx = 1