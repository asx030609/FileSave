@ echo off

echo �������ó�������ԱȨ��... 
%1 %2
ver|find "5.">nul&&goto :st
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :st","","runas",1)(window.close)&goto :eof

:st
copy "%~0" "%windir%\system32\"
echo ���ó�������ԱȨ�޳ɹ�


echo ��ת��one���֣���:one��ʼ��
goto one

:three
@echo three
E:
del "E:\test\a1\b1\c1\d1\" /s /q
rd "E:\test\a1\b1\c1\d1\" /s /q
pause

:one

dir
::����ð�ź���Ǳ�ע������ʾ��Щ��ע��Ҫ���б�ע����Ȼ��Ӱ��ͬһ�е�����ᵼ������dir�޷�ִ��
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


:two
@echo part-2��dos�����ļ��У���E���µġ�ʹ��bat����IP���ļ����µ������ļ�����д���ļ�
set work_path=E:\repository\FileSaveV1\ʹ��bat����IP
E: 	
cd %work_path% 
for /R %%s in (.,*) do ( 
dir /b %%s
type %%s >>E:\20200701.txt
)
pause