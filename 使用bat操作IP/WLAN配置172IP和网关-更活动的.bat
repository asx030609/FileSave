@ echo off
echo 正在启用超级管理员权限... 
%1 %2
ver|find "5.">nul&&goto :st
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :st","","runas",1)(window.close)&goto :eof

:st
copy "%~0" "%windir%\system32\"
echo 启用超级管理员权限成功

goto startone


:startone
@echo off
REM WLAN连接名称
::set NetName = "WLAN"
netsh interface ipv4 set address name="WLAN" source=dhcp
echo set static IP
REM 添加IP
netsh interface ipv4 add address name="WLAN"  addr=172.30.10.24 mask=255.255.224.0 gateway=172.30.0.1 gwmetric=0 
goto end
netsh interface ipv4 add address name="WLAN" addr=192.168.43.143 mask=255.255.255.0 gateway=192.168.43.206 gwmetric=0 
netsh interface ipv4 add address name="WLAN" addr=192.168.1.114 mask=255.255.255.0 gateway=192.168.1.1 gwmetric=0 
netsh interface ipv4 add address name="WLAN" addr=10.65.27.144 mask=255.255.255.192 gateway=10.65.27.129 gwmetric=0
netsh interface ipv4 set dns "WLAN" static 192.168.43.206 primary
::netsh interface ipv4 set dns "WLAN" static 192.168.43.206 primary ::validate=no
::netsh interface ip add dns "WLAN" 192.168.43.233 index=2 
goto end

:start
@echo off
@echo 开始设置IP
netsh interface ip set address name="WLAN" source=static addr=192.168.0.234 mask=255.255.255.0 gateway=192.168.0.1 gwmetric=0
netsh interface ip set dns name="WLAN" source=static addr=114.114.114.114 primary
netsh interface ip add dns name="WLAN" address=8.8.8.8 index=2
::DNS要紧跟在静态IP后，放在其他地方会导致错误。
netsh interface ip add address name="WLAN" addr=192.168.0.240 mask=255.255.255.0 gateway=192.168.0.1 gwmetric=0
netsh interface ipv4 add address name="WLAN"  addr=172.30.10.122 mask=255.255.224.0 gateway=172.30.0.1 gwmetric=0
@echo on
@echo IP已设置
@echo off
goto end

:end
@echo on
ipconfig /flushdns
ipconfig /all
pause