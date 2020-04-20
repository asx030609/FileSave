--select instr('11,222,3333,44444',',') test1 from dual;
--select instr('11,222,3333,44444',',',1,2) test2 from dual;
select instr(',11,222,3333,44444',',',1,1) test2 from dual;
select instr(',11,222,3333,44444',',') test2 from dual;
--select substr('11,222,3333,44444', 2, 3) AB from dual;
--select substr('11,222,3333,44444', 3, 1) AB from dual;
--select substr('11,222,3333,44444',instr('11,222,3333,44444',','),length('11,222,3333,44444')-instr('11,222,3333,44444',',')) from dual;