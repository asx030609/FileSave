@echo off

d:

set fuck=1
:loop
ping 172.30.20.27 >>ping20_27.txt
echo %date%%time% >>ping20_27.txt
set /a fuck+=1
goto loop