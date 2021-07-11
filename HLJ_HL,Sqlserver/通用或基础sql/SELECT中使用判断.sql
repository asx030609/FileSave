SELECT case when count(ProductCode)=0 then newid() else (select top 1 id from [BI_ProductUnit] where id='') end FROM [BI_ProductUnit] WHERE ProductCode='00604600048' group by ProductCode;


SELECT case when count(ProductCode)=0 then newid() else min(Id) end FROM [BI_ProductUnit] WHERE ProductCode='00604600048' group by ProductCode;