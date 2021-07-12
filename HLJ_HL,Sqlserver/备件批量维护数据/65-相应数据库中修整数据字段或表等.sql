use [TestDB]
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

----更新新添加字段数据
UPDATE TB01 SET ShelfNo=SUBSTRING(LocationName,1,2),LayerNo=SUBSTRING(LocationName, 4,2),LocationNo=SUBSTRING(LocationName,7,2);
UPDATE TB01 SET LocationCode=SUBSTRING(LocationName,1,2)+'-'+SUBSTRING(LocationName, 4,2)+'-'+SUBSTRING(LocationName,7,2);
GO
DECLARE @unitTotalNum int;
set @unitTotalNum = (select count(1) from TB01);
Declare @unitName nvarchar(50);
Declare @unitCode nvarchar(50);
Declare @transfer nvarchar(50);
declare @unitId nvarchar(50);
declare @v_Model nvarchar(32);
declare @IDNum int;
set @IDNum=1;
while(@IDNum <= @unitTotalNum)
begin
	--print(@IDNum);
	select @unitName=UnitName,@v_Model=Model from TB01 WHERE ID=@IDNum;	--ID是自增唯一键，identify(1,1)
	select @unitCode=UnitCode from FusionBJK.DBO.BI_ProductUnit WHERE UnitName=@unitName;
	select @transfer=TransferRate,@unitId=Id from FusionBJK.DBO.BI_ProductUnit WHERE UnitName=@unitName and UnitType=1;
	update TB01 set UnitCode=@unitCode,[Transfer]=@transfer where ID=@IDNum;
	if(ISNULL(@unitId,'')='')
		set @unitId=NEWID();
	update TB01 set ProductUnitId=@unitId where ID=@IDNum;
	if(ISNULL(@v_Model,'')<>'')
		update TB01 set ModelCode=@v_Model where ID=@IDNum;
	SET @IDNum=@IDNum+1;
end;

--SELECT SUBSTRING(LocationName,1,2) '架数',SUBSTRING(LocationName, 4,2) '层数',SUBSTRING(LocationName,7,2) '位数',LocationName FROM TB01;
SELECT * FROM TB01;