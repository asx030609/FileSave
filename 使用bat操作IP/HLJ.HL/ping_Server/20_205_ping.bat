@echo off

d:

set fuck=1
:loop
ping 172.30.20.205 >>ping20_205.txt
echo %date%%time% >>ping20_205.txt
set /a fuck+=1
goto loop