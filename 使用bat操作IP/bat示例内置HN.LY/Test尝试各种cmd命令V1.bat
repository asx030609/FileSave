@ echo off

echo 正在启用超级管理员权限... 
%1 %2
ver|find "5.">nul&&goto :st
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :st","","runas",1)(window.close)&goto :eof

:st
copy "%~0" "%windir%\system32\"
echo 启用超级管理员权限成功


goto three

:three
@echo three
E:
del "E:\test\a1\b1\c1\d1\" /s /q
rd "E:\test\a1\b1\c1\d1\" /s /q
pause

:one
@echo 开始测试
set /p var=随便输入个命令: 
%var%
@echo off
if %ERRORLEVEL% == 0 (
   echo !var! 执行成功了
   ) ELSE (
   echo 基本上执行失败了..
   )
pause


:two
@echo part-2，dos遍历文件夹，把E盘下的使用bat操作IP文件夹下的所有文件都复写到文件
set work_path=E:\repository\FileSaveV1\使用bat操作IP
E: 
cd %work_path% 
for /R %%s in (.,*) do ( 
dir /b %%s
type %%s >>E:\20200701.txt
)
pause