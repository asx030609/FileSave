create or replace function GetStrLocateIndex 
(
  v_Input in varchar2,  --总字符串
  v_Find in varchar2
)
return integer
is
  lv_str varchar2(1024);
  lv_strOfIndex varchar2(1024);
  lv_Index number;
  lv_LocateIndex number := 0;
  tempNumber number := 0;
begin
  lv_str:=','||ltrim(rtrim(v_Input))||',';
  if (instr(lv_str,','||v_Find||',',1) != 0) then --如果存在这个字符串
    tempNumber := length(lv_str);
	  for i in 1 .. tempNumber LOOP
		lv_Index := instr(substr(lv_str,1,instr(lv_str,v_Find,1)),',',1,i);
		if(lv_Index = 0) then
		  lv_LocateIndex := i-1;
		end if;
		exit when(lv_Index = 0);
	  END LOOP;
  end if;
  if lv_LocateIndex!=0 then
    return lv_LocateIndex;
  else
    return 0;
  end if;
end GetStrLocateIndex;
/
set SERVEROUTPUT ON;
Declare
  i_TotalNumber Integer;
  i_Input varchar2(200);
  v_content varchar2(150);
Begin
  i_Input := '1111,2222,3333,4444,5555,666666,77777,8888,9999,kkk,101010,eeee';
  for i in 1 .. 1 LOOP
      v_content := GetStrLocateIndex(i_Input,'kkkk');
      dbms_output.put_line('结果为：'||v_content);
  END LOOP;
END;
/
drop function GetStrLocateIndex;