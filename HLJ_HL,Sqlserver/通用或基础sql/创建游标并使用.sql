use [FusionFLK]


DECLARE @projectId nvarchar(36)  -- ��������
DECLARE My_Cursor CURSOR --�����α�
FOR (SELECT MachineCode FROM WM_Machine) --�����Ҫ�ļ��Ϸŵ��α���
OPEN My_Cursor; --���α�
FETCH NEXT FROM My_Cursor INTO @projectId;
WHILE @@FETCH_STATUS = 0
    BEGIN
        print(@projectId);

        FETCH NEXT FROM My_Cursor INTO @projectId;
    END
CLOSE My_Cursor; --�ر��α�
DEALLOCATE My_Cursor; --�ͷ��α�