@ echo off
echo �������ó�������ԱȨ��... 
%1 %2
ver|find "5.">nul&&goto :st
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :st","","runas",1)(window.close)&goto :eof
:st
copy "%~0" "%windir%\system32\"
echo ���ó�������ԱȨ�޳ɹ�

netsh interface ipv4 set address name="��̫��" source=dhcp
netsh interface IP set dns "WLAN" dhcp

echo *****���óɹ�������IP�ѻָ�Ϊ��̬ip
pause