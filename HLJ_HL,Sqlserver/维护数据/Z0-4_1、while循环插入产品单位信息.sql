use [FusionFLK]

declare @IsExist int;
declare @ProductCode varchar(50);
declare @BrandCode varchar(50);
declare @MachineName varchar(50);
declare @BrandName varchar(50);


DECLARE My_Cursor CURSOR --�����α�
FOR (SELECT DISTINCT ProductCode FROM BI_Product) --�����Ҫ�ļ��Ϸŵ��α���

OPEN My_Cursor; --���α꣬�����в���
FETCH NEXT FROM My_Cursor INTO @ProductCode;
WHILE @@FETCH_STATUS = 0
    BEGIN
		set @MachineName='';
		IF exists(SELECT * FROM BI_Product WHERE ProductCode=@ProductCode)
			print(@MachineName+@ProductCode);
		else
			print('�����ڴ˲�Ʒ');
        FETCH NEXT FROM My_Cursor INTO @ProductCode;
    END
CLOSE My_Cursor; --�ر��α�
DEALLOCATE My_Cursor; --�ͷ��α�
