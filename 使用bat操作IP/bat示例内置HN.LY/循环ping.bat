@echo off

d:

for /L %%i in (1,1,%999999999%) do (
echo %1  >>ping.txt
echo 1% >>ping.txt
echo %% >>ping.txt
echo %date%%time% >> ping.txt
)
@echo on
echo %date%%time% >> ping.txt
@echo ready show
echo %%
echo 1%
@echo %1&&dir

pause