@echo off

d:

for /L %%i in (1,1,%999999999%) do (
ping 172.30.20.205 >>20_205_ping.txt
echo %date%%time% >> 20_205_ping.txt
)

pause