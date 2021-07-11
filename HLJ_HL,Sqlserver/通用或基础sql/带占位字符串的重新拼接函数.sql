GO
----����ʹ���ĸ�ռλ���ĺ���������ƴ���ַ���
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[f_PlaceHolderStr]') and xtype in (N'FN', N'IF', N'TF'))
	drop function [dbo].f_PlaceHolderStr;
GO
----���@inputStr����Ӧ��@���ˣ��򲻴���
CREATE FUNCTION dbo.f_PlaceHolderStr(@inputStr nvarchar(500), @param01 nvarchar(20), @param02 nvarchar(20), @param03 nvarchar(20), @param04 nvarchar(20))
returns nvarchar(500)	--Ҫ����500����Ȼ�᷵��nvarchar�ַ�
AS
begin
	declare @placeStr nvarchar(20)='@';
	declare @output nvarchar(200)=@inputStr;
	declare @index04 int=CHARINDEX('@4',@inputStr);
	declare @index03 int=CHARINDEX('@3',@inputStr);
	declare @index02 int=CHARINDEX('@2',@inputStr);
	declare @index01 int=CHARINDEX('@1',@inputStr);
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
set @ret = dbo.f_PlaceHolderStr('select * from wm_pallet where locationCode=@1 and id=@2 and productCode=@3', '', '', '-3', '-4');
print(@ret);