GO
----����ʹ���ĸ�ռλ���ĺ���������ƴ���ַ���
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[f_PlaceHolderStr]') and xtype in (N'FN', N'IF', N'TF'))
	drop function [dbo].f_PlaceHolderStr;
GO
----���@inputStr����Ӧ��@���ˣ��򲻴���
CREATE FUNCTION dbo.f_PlaceHolderStr(@inputStr nvarchar(1000), @param01 nvarchar(100), @param02 nvarchar(100), @param03 nvarchar(100), @param04 nvarchar(100)
	, @param05 nvarchar(100))
returns nvarchar(1000)	--Ҫ����1000����Ȼ�᷵��nvarchar�ַ�
AS
begin
	declare @placeStr nvarchar(20)='@';
	declare @output nvarchar(1000)=@inputStr;
	declare @index05 int=CHARINDEX('@5',@inputStr);
	declare @index04 int=CHARINDEX('@4',@inputStr);
	declare @index03 int=CHARINDEX('@3',@inputStr);
	declare @index02 int=CHARINDEX('@2',@inputStr);
	declare @index01 int=CHARINDEX('@1',@inputStr);
	IF @index05 > 0 
		set @output=Replace(@output, @placeStr+'5', @param03);
	IF @index04 > 0 --and (ISNULL(@param04, '')<>'') --����������ˣ���Ϊ��ʱ��Ҫ�������滻Ϊ���ַ���
		set @output=Replace(@output, @placeStr+'4', @param04);
	IF @index03 > 0 
		set @output=Replace(@output, @placeStr+'3', @param03);
	IF @index02 > 0 
		set @output=Replace(@output, @placeStr+'2', @param02);
	IF @index01 > 0 
		set @output=Replace(@output, @placeStr+'1', @param01);
	return @output;
end
GO

declare @ret nvarchar(300);
--set @ret = dbo.f_PlaceHolderStr('select * from wm_pallet where locationCode=@1 and id=@2 and productCode=@3', '1', '2', '3', default);	--��������Ĭ��ֵʱʹ��default
set @ret = dbo.f_PlaceHolderStr('select * from wm_pallet where locationCode=@1 and id=@2 and productCode=@3', '', '', '-3', '-4','-5');
print(@ret);