SELECT NEWID();			--ED60940F-7B95-4181-AC35-0BF7F8679639
SELECT SYSDATETIME();	--2021-01-30 16:06:04.3496632
SELECT SUBSTRING('1234567890abcdef', 0, 1);		--��	----SubString�Ǵ�����1��ʼ��
SELECT SUBSTRING('1234567890abcdef', 1, 1);		--1
SELECT SUBSTRING('1234567890abcdef', 1, 2);		--12
SELECT SUBSTRING('1234567890abcdef', 2, 1);		--2
SELECT CHARINDEX(' ', ' 123456');	--1�������Ǵ�1��ʼ��
SELECT CHARINDEX(' ', '123456');	--0�������Ǵ�1��ʼ�ģ�����������������Ϊ0

--1��SUBSTRING����ȡ�ַ�����
--2��CHARINDEX������ĳһ�ַ�����һ���ַ����е�����λ�ã�
--3��REVERSE����תĳһ�ַ�����
SELECT SUBSTRING('NAME01 COLOR01', 1, LEN('NAME01 COLOR01')-CHARINDEX(' ', REVERSE('NAME01 COLOR01'))); --���ΪNAME01��--������+�ո�+��ɫ���ַ�����ȥ����ɫ
SELECT LEN('NAME01 COLOR01')-CHARINDEX(' ', REVERSE('NAME01 COLOR01'));		--6
SELECT CHARINDEX(' ', REVERSE('NAME01 COLOR01'));	--8
SELECT REVERSE('NAME01 COLOR01');		--10ROLOC 10EMAN

DECLARE @LEN_ INT;
set @LEN_ = 5;
SELECT RIGHT(replicate('0', @LEN_)+'2', @LEN_);	----��0���㵽@LEN_λ
SELECT RIGHT(replicate('0', 5)+'2', 5);	----��0���㵽5λ
SELECT LEFT('2' + replicate('0', 4), 4);		----��0�ֲ��㵽4λ

----*****���飬ѡ��ǰ�漸��
----SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY GETDATE()) AS ROWNUM,TB_A.* FROM WM_Location TB_A ORDER BY LocationCode) TB_B 
----	WHERE TB_B.ROWNUM <=10;		----�����������⻹ָ���� TOP��OFFSET �� FOR XML������ORDER BY �Ӿ�����ͼ�������������������Ӳ�ѯ�͹��ñ���ʽ����Ч��
----*****�ϸ������Ҫʹ��Top���У�ԭ��������һ�����SELECT��ʵ�����Ƿ���һ��������һ���αꡣ��Դ�ڣ�https://blog.csdn.net/qq_39569480/article/details/104655485
SELECT TOP 10 TB_A.* FROM  WM_Location TB_A ORDER BY LocationCode
----*****���� ��� oracle �� sql server Ӧ�ö���֧�ֵ�
select * FROM  WM_Location order by LocationCode desc OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;