@echo ��ʼ����
set /p var=������������: 
%var%

@echo off
if %ERRORLEVEL% == 0 (
   echo !var! ִ�гɹ���
   ) ELSE (
   echo ������ִ��ʧ����..
   )
pause