@echo off

d:

for /L %%i in (1,1,%999999999%) do (
ping %1192.168.1.1 -n 1% && echo %% >>ping.txt
date /t >>ping.txt
time /t >>ping.txt
)
@echo on
echo %date%%time% >> ping.txt
@echo ready show
echo %%
echo 1%
@echo %1&&dir

pause