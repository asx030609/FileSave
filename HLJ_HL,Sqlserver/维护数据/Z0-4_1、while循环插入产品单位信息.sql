use [FusionFLK]

declare @IsExist int;
declare @ProductCode varchar(50);
declare @BrandCode varchar(50);
declare @MachineName varchar(50);
declare @BrandName varchar(50);


DECLARE My_Cursor CURSOR --定义游标
FOR (SELECT DISTINCT ProductCode FROM BI_Product) --查出需要的集合放到游标中

OPEN My_Cursor; --打开游标，并进行操作
FETCH NEXT FROM My_Cursor INTO @ProductCode;
WHILE @@FETCH_STATUS = 0
    BEGIN
		set @MachineName='';
		IF exists(SELECT * FROM BI_Product WHERE ProductCode=@ProductCode)
			print(@MachineName+@ProductCode);
		else
			print('不存在此产品');
        FETCH NEXT FROM My_Cursor INTO @ProductCode;
    END
CLOSE My_Cursor; --关闭游标
DEALLOCATE My_Cursor; --释放游标
