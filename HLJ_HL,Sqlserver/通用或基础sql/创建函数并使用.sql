
IF OBJECT_ID(N'dbo.fn_01', N'IF') is not null
	drop function fn_01;
GO
create function dbo.fn_01(@v_temp int)
returns int
AS
begin
	set @v_temp = 1;
	return @v_temp;
end;
go