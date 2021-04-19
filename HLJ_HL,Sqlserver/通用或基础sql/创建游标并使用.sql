use [FusionFLK]


DECLARE @projectId nvarchar(36)  -- 声明变量
DECLARE My_Cursor CURSOR --定义游标
FOR (SELECT MachineCode FROM WM_Machine) --查出需要的集合放到游标中
OPEN My_Cursor; --打开游标
FETCH NEXT FROM My_Cursor INTO @projectId;
WHILE @@FETCH_STATUS = 0
    BEGIN
        print(@projectId);

        FETCH NEXT FROM My_Cursor INTO @projectId;
    END
CLOSE My_Cursor; --关闭游标
DEALLOCATE My_Cursor; --释放游标