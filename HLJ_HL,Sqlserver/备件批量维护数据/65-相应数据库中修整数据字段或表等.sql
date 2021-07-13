use [TestDB]
/*
Alter table TB01 ADD ShelfNo nvarchar(50);
GO
Alter table TB01 ADD LocationNo nvarchar(50);
GO
Alter table TB01 ADD LayerNo nvarchar(50);
GO
Alter table TB01 ADD LocationCode nvarchar(50);
GO
Alter table TB01 ADD ID INT IDENTITY(1,1);
GO
Alter table TB01 add UnitCode nvarchar(50);
GO
Alter table TB01 add [Transfer] nvarchar(50);
GO
Alter table TB01 add ProductUnitId nvarchar(50);
GO
Alter table TB01 add ModelCode nvarchar(32);
GO

----����������ֶ�����
UPDATE TB01 SET ShelfNo=SUBSTRING(LocationName,1,2),LayerNo=SUBSTRING(LocationName, 4,2),LocationNo=SUBSTRING(LocationName,7,2);
UPDATE TB01 SET LocationCode=SUBSTRING(LocationName,1,2)+'-'+SUBSTRING(LocationName, 4,2)+'-'+SUBSTRING(LocationName,7,2);
GO
--*/
if exists(select * from dbo.sysobjects where id=object_id(N'pro_001') and OBJECTPROPERTY(id, N'IsProcedure')=1)	--����ʹ��select * from dbo.sysobjects where xtype='P';��
	drop procedure pro_001;
go
----�����������һ��һ�����32λ�����������Ͼ�Ȼ���Ե�58
----1-N��1-M�㣬N��M�Ѿ��̶���Ҫ����̶��Ļ��������33-58λ
----�ҳ�N��M
create PROC pro_001
AS
BEGIN
	DECLARE @unitTotalNum int;
	set @unitTotalNum = (select count(1) from TB01);
	Declare @unitName nvarchar(50);
	Declare @unitCode nvarchar(50);
	Declare @transfer nvarchar(50);
	Declare @v_ProductCode nvarchar(100);
	declare @unitId nvarchar(50);
	declare @v_Model nvarchar(32);
	declare @IDNum int;
	if OBJECT_ID('tempdb..#TP_01') is not null drop table #TP_01;
	SELECT *
	into #TP_01
	FROM
	(SELECT ProductUnitId,UnitName,ProductCode FROM TB01 where 1=0) AS A;

	set @IDNum=1;
	while(@IDNum <= @unitTotalNum)
	begin
		----print(@IDNum);
		select @unitName=UnitName,@v_Model=Model,@v_ProductCode=ProductCode from TB01 WHERE ID=@IDNum;	--ID������Ψһ����identify(1,1)
		--select @unitCode=UnitCode from FusionBJK.DBO.BI_ProductUnit WHERE UnitName=@unitName;
		--select @transfer=TransferRate,@unitId=Id from FusionBJK.DBO.BI_ProductUnit WHERE UnitName=@unitName and UnitType=1;
		set @unitId = null;
		select @unitId=ProductUnitId from #TP_01 WHERE UnitName=@unitName and ProductCode=@v_ProductCode;
		--ͨ�����������Խ�ȥ��@unitId������ʹ��select @unitId=ProductUnitId from TB01 WHERE UnitName=@unitName and ProductCode=@v_ProductCode;
		--�������ʹ��Update������,�õ��Ľ��ҲΪnull��գ�������Ϊselect @unitId��ȡ�����������ݵ��µ��𣿺��п���
		--Ҫͨ����ʱ��ʽ,
		--IF(@v_ProductCode='00604569790')	
		--	PRINT(@v_ProductCode);
		--print(@unitId + '-' + @v_ProductCode);
		--update TB01 set UnitCode=@unitCode,[Transfer]=@transfer where ID=@IDNum;
		if(''=ISNULL(@unitId,''))
			set @unitId=NEWID();
		ELSE
			PRINT('���ڲ�Ʒ'+ @v_ProductCode);
		--print(@unitId + ',' + @v_ProductCode);
		update TB01 set ProductUnitId=@unitId where ID=@IDNum;
		Insert into #TP_01 SELECT @unitId,@unitName,@v_ProductCode;
		--if(ISNULL(@v_Model,'')<>'')
		--	update TB01 set ModelCode=@v_Model where ID=@IDNum;
		SET @IDNum=@IDNum+1;
	end;
END;
GO
EXECUTE pro_001;
GO
--SELECT SUBSTRING(LocationName,1,2) '����',SUBSTRING(LocationName, 4,2) '����',SUBSTRING(LocationName,7,2) 'λ��',LocationName FROM TB01;
--SELECT * FROM TB01;