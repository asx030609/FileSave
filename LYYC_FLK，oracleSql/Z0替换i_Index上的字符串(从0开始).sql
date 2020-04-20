create or replace function SetStrOfIndex --将0,1,2,3,4,5,6上的i键上的内容替换，其中对应关系是0,None；1,Bool；2,ByteBool；3,Byte,4,Short；5,Word；6,Dword；7,Int；8,Float；9,Sys；11,Str；不连续的index对应内容默认设置为0
(
  v_Input in varchar2,  --总字符串
  i_Index in varchar2,  --替换第几个元素,索引从0开始
  v_ReplaceStr in varchar2 --要替换成的字符
)
return varchar2 --最终返回的子字符串
is
  lv_str varchar2(1024);
  lv_strOfIndex varchar2(1024);
  lv_length number;
  temp_varchar varchar2(1024);
begin
  lv_str:=ltrim(rtrim(v_Input));
  lv_str:=concat(lv_str,',');
  lv_length:=i_Index;
  if lv_length=0 then
      lv_str:=v_ReplaceStr||substr(lv_str,instr(lv_str,','),(length(lv_str))-instr(lv_str,','));
  else
      lv_length:=i_Index+1;
      if(0=instr(lv_str,',',1,lv_length)) then  --如果到达最尾端，这里先保留原值，UNDO，以后再根据索引添加N个',0'吧
        return v_Input;
      end if;
      temp_varchar := substr(lv_str,instr(lv_str,',',1,lv_length),length(lv_str)-instr(lv_str,',',1,lv_length));
      lv_str:= substr(lv_str,1,instr(lv_str,',',1,i_Index))||v_ReplaceStr||temp_varchar;
  end if;
  return  lv_str;
end SetStrOfIndex;
/
set SERVEROUTPUT ON;
Declare
  i_TotalNumber Integer;
  i_Input varchar2(200);
  v_content varchar2(150);
Begin
  i_Input := '1111,2222,3333,4444,5555,666666,77777,8888,9999,101010';
  for i in 1 .. 11 LOOP
    v_content := SetStrOfIndex(i_Input,i, 'ffff');
    if v_content is null then
      dbms_output.put_line('第'||i||'索引结果为空');
    else 
      dbms_output.put_line('第'||i||'索引结果为：'||v_content);
    end if;
  END LOOP;
END;
/
drop function SetStrOfIndex;