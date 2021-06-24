@echo off

d:

set fuck=1
:loop
ping 172.30.20.19 >>ping20_19.txt
echo %date%%time% >>ping20_19.txt
set /a fuck+=1
goto loop