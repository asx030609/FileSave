create or replace function get_tabletype(tablename in varchar2)
return varchar2 
is
v_tabletype varchar2(100);
begin
if instr(tablename,'tlk_p_news')>0 then
v_tabletype:='XWSD';
end if;
v_tabletype:='others';
return(v_tabletype);
end get_tabletype;
/
select get_tabletype('23') from dual;