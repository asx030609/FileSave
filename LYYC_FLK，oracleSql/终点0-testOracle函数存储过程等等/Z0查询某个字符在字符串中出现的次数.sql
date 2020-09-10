create or replace function GET_OCCUR_COUNT
(
  V_IN_STR varchar2,  --字符串
  av_split varchar2  --某个字符
)
return NUMBER --返回某个字符串出现的次数
is
  V_STR varchar2(1024);
  I_INDEX number;
  I_OCCUR_NUM NUMBER := 0;
begin
  V_STR:=ltrim(rtrim(V_IN_STR));
  --FOR I IN 0 .. 7
  LOOP
    I_INDEX:=instr(V_STR, av_split);
      I_OCCUR_NUM := I_OCCUR_NUM + 1;
    IF I_INDEX != 0 THEN
      V_STR := substr(V_STR, I_INDEX + LENGTH(av_split));
    END IF;
  --dbms_output.put_line(I_INDEX || '    ' || V_STR || '    ');
    EXIT WHEN I_INDEX = 0;
  END LOOP;
  return  I_OCCUR_NUM;
end;
/
set SERVEROUTPUT ON;
Declare
  i_TotalNumber Integer;
  i_Input varchar2(200);
  v_content varchar2(150);
Begin
  i_Input := '1111 2222$3333 4444$5555$666666$77777$8888$9999$10101 23';
  v_content := GET_OCCUR_COUNT(i_Input, ' ');
  dbms_output.put_line(v_content);
END;