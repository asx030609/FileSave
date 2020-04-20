create or replace function Get_StrArrayStrOfIndex
(
  av_str varchar2,  --要分割的字符串
  av_split varchar2,  --分隔符号
  av_index number --取第几个元素
)
return varchar2
is
  lv_str varchar2(1024);
  lv_strOfIndex varchar2(1024);
  lv_length number;
begin
  lv_str:=ltrim(rtrim(av_str));
  lv_str:=concat(lv_str,av_split);
  lv_length:=av_index;
  if lv_length=0 then
      lv_strOfIndex:=substr(lv_str,1,instr(lv_str,av_split)-length(av_split));
  else
      lv_length:=av_index+1;
     lv_strOfIndex:=substr(lv_str,instr(lv_str,av_split,1,av_index)+length(av_split),instr(lv_str,av_split,1,lv_length)-instr(lv_str,av_split,1,av_index)-length(av_split));
  end if;
  return  lv_strOfIndex;
end Get_StrArrayStrOfIndex;
/
set SERVEROUTPUT ON;
Declare
  i_TotalNumber Integer;
  i_Input varchar2(200);
  v_content varchar2(150);
Begin
  i_Input := '1111 2222$3333 4444$5555$666666$77777$8888$9999$10101 23';
  i_TotalNumber := length(i_Input) / 3;
  for i in 0 .. i_TotalNumber
  LOOP
    v_content := Get_StrArrayStrOfIndex(i_Input, ' ', i);
    if(v_content is not null) then
      dbms_output.put_line(v_content);
    elsif (v_content is null) then
      dbms_output.put_line('null');
    else
      dbms_output.put_line('空字符串');
    end if;
  END LOOP;
END;