--DELETE FROM DMT_InteractiveData;
update TM_Task SET TaskStatus=2;
Declare @increment_num int;
set @increment_num=10;
UPDATE TM_Task SET TaskNo=(TaskNo+@increment_num);


----2,3,4,5��1#�Ѷ������->����˵� �������+��������Ȼ����������μ�@increment_num
----6,7,8,9��2#�Ѷ������->����˵� �������+��������Ȼ����������μ�@increment_num