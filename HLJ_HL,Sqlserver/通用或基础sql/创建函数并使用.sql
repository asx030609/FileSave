
--IF OBJECT_ID(N'dbo.fn_01', N'IF') is not null	--开始还以为有用，2021年7月10日16:16:09，但这次多次执行后，没效果了
--	drop function fn_01;
--GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_01]') and xtype in (N'FN', N'IF', N'TF'))
	drop function [dbo].fn_01;
GO
create function dbo.fn_01(@v_temp int)
returns int
AS
begin
	set @v_temp = 1;
	return @v_temp;
end;
go