CREATE OR REPLACE FUNCTION "FUN_GET_QUERYCODE" (
	v_string IN varchar2, 
	v_spellFlag IN number
)
RETURN varchar2
AS
I number(5);
	li_sqlcode number;
	li_count number;
	ls_sqlerrm varchar2(128);
	Ls_ReturnStr varchar2(50);
	Ls_ch varchar2(10);
	Ls_temp varchar2(10);
BEGIN
	IF v_string IS NULL THEN
		RETURN v_string;
	END IF;
	ls_ReturnStr := NULL;
	I := 1;
	li_count := Length(substr(v_string, 1, 30));
	FOR i IN 1..li_count
	LOOP
		ls_ch := substr(v_string, i, 1);
		BEGIN
			IF v_spellFlag = 0 THEN
				-- ²éÑ¯Îå±ÊÂë
				SELECT WB_CODE
				INTO Ls_temp
				FROM C_SPELLBASE
				WHERE NAME = ls_ch
					AND ROWNUM = 1;
			ELSE
				-- ²éÑ¯Æ´ÒôÂë
				SELECT PY_CODE
				INTO Ls_temp
				FROM C_SPELLBASE
				WHERE NAME = ls_ch
					AND ROWNUM = 1;
			END IF;
			ls_returnStr := ls_returnStr || ls_temp;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN ls_returnStr := ls_returnStr;
			WHEN OTHERS THEN
				li_sqlcode := sqlcode;
				ls_sqlerrm := substr(sqlerrm, 1, 128);
				RETURN NULL;
		END;
	END LOOP;
	RETURN substr(ls_returnStr, 1, 30);
END;

/
SET SERVEROUTPUT ON;
DECLARE
    V_TEMP VARCHAR2(50):='';
BEGIN
    V_TEMP := FUN_GET_QUERYCODE('ºº×Ö',3);
    DBMS_OUTPUT.PUT_LINE(V_TEMP);
END;