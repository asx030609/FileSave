--DELETE FROM DMT_InteractiveData;
update TM_Task SET TaskStatus=2;
Declare @increment_num int;
set @increment_num=10;
UPDATE TM_Task SET TaskNo=(TaskNo+@increment_num);


----2,3,4,5是1#堆垛机入库端->出库端的 入库任务+出库任务，然后任务号依次加@increment_num
----6,7,8,9是2#堆垛机入库端->出库端的 入库任务+出库任务，然后任务号依次加@increment_num