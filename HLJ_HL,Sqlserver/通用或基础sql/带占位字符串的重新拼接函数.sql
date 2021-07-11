GO
----创建使用四个占位符的函数，方便拼接字符串
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[f_PlaceHolderStr]') and xtype in (N'FN', N'IF', N'TF'))
	drop function [dbo].f_PlaceHolderStr;
GO
----如果@inputStr中相应的@少了，则不代替
CREATE FUNCTION dbo.f_PlaceHolderStr(@inputStr nvarchar(500), @param01 nvarchar(20), @param02 nvarchar(20), @param03 nvarchar(20), @param04 nvarchar(20))
returns nvarchar(500)	--要带上500，不然会返回nvarchar字符
AS
begin
	declare @placeStr nvarchar(20)='@';
	declare @output nvarchar(200)=@inputStr;
	declare @index04 int=CHARINDEX('@4',@inputStr);
	declare @index03 int=CHARINDEX('@3',@inputStr);
	declare @index02 int=CHARINDEX('@2',@inputStr);
	declare @index01 int=CHARINDEX('@1',@inputStr);
	IF @index04 > 0 --and (ISNULL(@param04, '')<>'') --不带上这个了，因为有时需要把内容替换为空字符串
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
--set @ret = dbo.f_PlaceHolderStr('select * from wm_pallet where locationCode=@1 and id=@2 and productCode=@3', '1', '2', '3', default);	--参数设置默认值时使用default
set @ret = dbo.f_PlaceHolderStr('select * from wm_pallet where locationCode=@1 and id=@2 and productCode=@3', '', '', '-3', '-4');
print(@ret);