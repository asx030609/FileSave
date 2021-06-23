@echo off

d:

for /L %%i in (1,1,%999999999%) do (
ping 172.30.19.12 >>19_12_ping.txt
echo %date%%time% >> 19_12_ping.txt
)

pause