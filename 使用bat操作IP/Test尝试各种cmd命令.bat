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