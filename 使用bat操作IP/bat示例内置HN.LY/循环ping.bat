@echo off

d:

::for /L %%i in (1,1,%999999999%) do (
echo %1  >>ping.txt
echo 1% >>ping.txt
echo %% >>ping.txt
::ping %1192.168.1.1 -n 1% && echo %% >>ping.txt
::date /t >>ping.txt
::time /t >>ping.txt
echo %date%%time% >> ping.txt
::)
@echo on
@echo ready show
echo %%%
echo 1%
@echo %1&&dir

pause