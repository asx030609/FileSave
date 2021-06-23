@echo off

d:

set fuck=1
:loop
ping 192.168.1.1 >>test.txt
echo %date%%time% >>test.txt
set /a fuck+=1
goto loop