@echo off

d:

for /L %%i in (1,1,%999999999%) do (
ping %1192.168.1.1 -n 1% >>ping.txt
echo %date%%time% >> ping.txt
)

pause