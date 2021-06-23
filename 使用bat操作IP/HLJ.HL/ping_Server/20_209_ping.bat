@echo off

d:

set fuck=1
:loop
ping 172.30.20.209 >>ping20_209.txt
echo %date%%time% >>ping20_209.txt
set /a fuck+=1
goto loop