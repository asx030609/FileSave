@echo off

d:

set fuck=1
:loop
ping 172.30.20.206 >>ping20_206.txt
echo %date%%time% >>ping20_206.txt
set /a fuck+=1
goto loop