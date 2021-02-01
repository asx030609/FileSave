use FusionPFK;
GO
--create
exec sp_addtype enum ,'char(1)', 'not null'
go
create table t 
(
	a  enum  default('F') check(a  in ('T','F')),
)
go

SELECT * FROM t;
--drop 
drop table t;
go
exec sys.sp_droptype enum;
go