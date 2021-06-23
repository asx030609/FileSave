@echo off

d:

set fuck=1
:loop
ping 172.30.19.12 >>ping19_12.txt
echo %date%%time% >>ping19_12.txt
set /a fuck+=1
goto loop