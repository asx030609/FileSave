use [FusionFLK]

declare @ExistCount int;
declare @ProductCode varchar(50);
declare @ProductName varchar(50);
declare @BrandCode varchar(50);
declare @MachineName varchar(50);
declare @BrandName varchar(50);


DECLARE My_Cursor CURSOR --定义游标
FOR (SELECT DISTINCT ProductCode FROM BI_Product) --查出需要的集合放到游标中

OPEN My_Cursor; --打开游标，并进行操作
FETCH NEXT FROM My_Cursor INTO @ProductCode;
WHILE @@FETCH_STATUS = 0
    BEGIN
		set @ExistCount=0;
		----单位类型，Piece=1,Bar=2,Package=3,StandardPiece=4,StandardBar=5,WarehouseUnit=6,WorkshopUnit=7,BigUnit=8,SmallUnit=9,ReserveUnit=10,PlaceUnit=11	
		----单位类型，1是仓库单位2是车间单位----1代表true，0代表false
		SELECT @ExistCount=count(productCode) FROM BI_ProductUnit WHERE ProductCode=@ProductCode and UnitType=1;
		select @ProductName=ProductName FROM BI_Product WHERE ProductCode=@ProductCode;
		IF @ExistCount<=0
			begin
			print('不存在此产品仓库单位'+@productCode + @productName);
			INSERT [dbo].[BI_ProductUnit]([Id], [ProductCode], [UnitCode], [UnitName], [UnitType], [TransferRate], [Active], [DefaultUnit], [CreateTime], [UpdateTime], [RowVersion]) VALUES (NEWID(), @ProductCode, '13', '个', 1, 1, 'True', 'True', CONVERT(datetime, '2021/4/8 15:31:42', 101), CONVERT(datetime, '2021/4/8 15:31:42', 101), NEWID());
			end
		set @ExistCount=0;
		SELECT @ExistCount=count(productCode) FROM BI_ProductUnit WHERE ProductCode=@ProductCode and UnitType=2;
		select @ProductName=ProductName FROM BI_Product WHERE ProductCode=@ProductCode;
		IF @ExistCount<=0
			begin
			print('不存在此产品车间单位'+@productCode + @productName);
			INSERT [dbo].[BI_ProductUnit]([Id], [ProductCode], [UnitCode], [UnitName], [UnitType], [TransferRate], [Active], [DefaultUnit], [CreateTime], [UpdateTime], [RowVersion]) VALUES (NEWID(), @ProductCode, '13', '个', 2, 1, 'True', 'False', CONVERT(datetime, '2021/4/8 15:31:42', 101), CONVERT(datetime, '2021/4/8 15:31:42', 101), NEWID());	
			end
		FETCH NEXT FROM My_Cursor INTO @ProductCode;
    END
CLOSE My_Cursor; --关闭游标
DEALLOCATE My_Cursor; --释放游标
