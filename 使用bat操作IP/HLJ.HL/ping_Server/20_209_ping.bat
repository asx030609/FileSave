@echo off

d:

for /L %%i in (1,1,%999999999%) do (
ping 172.30.20.209 >>20_209_ping.txt
echo %date%%time% >> 20_209_ping.txt
)

pause