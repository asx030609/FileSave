@ echo off
echo 正在启用超级管理员权限... 
%1 %2
ver|find "5.">nul&&goto :st
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :st","","runas",1)(window.close)&goto :eof
:st
copy "%~0" "%windir%\system32\"
echo 启用超级管理员权限成功

netsh interface ipv4 set address name="以太网" source=dhcp
netsh interface IP set dns "WLAN" dhcp

echo *****设置成功！您的IP已恢复为动态ip
pause