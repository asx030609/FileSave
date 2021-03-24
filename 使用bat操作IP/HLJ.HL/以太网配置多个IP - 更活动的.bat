@ echo off
echo 正在启用超级管理员权限... 
%1 %2
ver|find "5.">nul&&goto :st
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :st","","runas",1)(window.close)&goto :eof

:st
copy "%~0" "%windir%\system32\"
echo 启用超级管理员权限成功

netsh interface ipv4 set address name="以太网" source=dhcp
echo set static IP
REM 添加IP
netsh interface ipv4 add address name="以太网"  addr=172.30.10.22 mask=255.255.0.0 gateway=172.30.20.1 gwmetric=0
::goto end
netsh interface ipv4 add address name="以太网" addr=199.199.180.6 mask=255.255.255.0 gateway=199.199.180.254 gwmetric=0
netsh interface ipv4 add address name="以太网"  addr=192.168.1.14 mask=255.255.255.0 gateway=192.168.1.1 gwmetric=0
::黑龙江海林配置AP用如下
netsh interface ipv4 add address name="以太网"  addr=169.254.1.100 mask=255.255.0.0 gwmetric=0	
::有错netsh interface ipv4 set dns "以太网" static 218.85.152.99 primary 
::>nul
::有错netsh interface ip add dns "以太网" 218.85.157.99 index=2 
::>nul




goto end

:end
@echo on
ipconfig /flushdns
ipconfig /all
pause