@echo off

d:

set fuck=1
:loop
ping 172.30.20.62 >>ping20_62.txt
echo %date%%time% >>ping20_62.txt
set /a fuck+=1
goto loop