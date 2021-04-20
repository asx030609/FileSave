use [FusionFLK]

declare @ExistCount int;
declare @ProductCode varchar(50);
declare @ProductName varchar(50);
declare @BrandCode varchar(50);
declare @MachineName varchar(50);
declare @BrandName varchar(50);


DECLARE My_Cursor CURSOR --�����α�
FOR (SELECT DISTINCT ProductCode FROM BI_Product) --�����Ҫ�ļ��Ϸŵ��α���

OPEN My_Cursor; --���α꣬�����в���
FETCH NEXT FROM My_Cursor INTO @ProductCode;
WHILE @@FETCH_STATUS = 0
    BEGIN
		set @ExistCount=0;
		----��λ���ͣ�Piece=1,Bar=2,Package=3,StandardPiece=4,StandardBar=5,WarehouseUnit=6,WorkshopUnit=7,BigUnit=8,SmallUnit=9,ReserveUnit=10,PlaceUnit=11	
		----��λ���ͣ�1�ǲֿⵥλ2�ǳ��䵥λ----1����true��0����false
		SELECT @ExistCount=count(productCode) FROM BI_ProductUnit WHERE ProductCode=@ProductCode and UnitType=1;
		select @ProductName=ProductName FROM BI_Product WHERE ProductCode=@ProductCode;
		IF @ExistCount<=0
			begin
			print('�����ڴ˲�Ʒ�ֿⵥλ'+@productCode + @productName);
			INSERT [dbo].[BI_ProductUnit]([Id], [ProductCode], [UnitCode], [UnitName], [UnitType], [TransferRate], [Active], [DefaultUnit], [CreateTime], [UpdateTime], [RowVersion]) VALUES (NEWID(), @ProductCode, '13', '��', 1, 1, 'True', 'True', CONVERT(datetime, '2021/4/8 15:31:42', 101), CONVERT(datetime, '2021/4/8 15:31:42', 101), NEWID());
			end
		set @ExistCount=0;
		SELECT @ExistCount=count(productCode) FROM BI_ProductUnit WHERE ProductCode=@ProductCode and UnitType=2;
		select @ProductName=ProductName FROM BI_Product WHERE ProductCode=@ProductCode;
		IF @ExistCount<=0
			begin
			print('�����ڴ˲�Ʒ���䵥λ'+@productCode + @productName);
			INSERT [dbo].[BI_ProductUnit]([Id], [ProductCode], [UnitCode], [UnitName], [UnitType], [TransferRate], [Active], [DefaultUnit], [CreateTime], [UpdateTime], [RowVersion]) VALUES (NEWID(), @ProductCode, '13', '��', 2, 1, 'True', 'False', CONVERT(datetime, '2021/4/8 15:31:42', 101), CONVERT(datetime, '2021/4/8 15:31:42', 101), NEWID());	
			end
		FETCH NEXT FROM My_Cursor INTO @ProductCode;
    END
CLOSE My_Cursor; --�ر��α�
DEALLOCATE My_Cursor; --�ͷ��α�
