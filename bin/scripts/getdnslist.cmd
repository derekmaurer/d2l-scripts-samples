@echo off
goto :begin
#####################
#
#	2007-12-13 dmaurer@opentext.com
#	usage:   getdnslist.cmd subnet start end dns-server
#	
#	Scans DNS with nslookup from subnet.start to subnet.end against dns-server
#


:begin
set subnet = %1
set /a i = %2
set dnsserver = %4

:start
if %i% == %3 goto end

nslookup %1.%i% %4 | grep Name | sed s/Name:/%1.%i%/ >> %temp%\output.txt

set /a i+=1
goto start


:end

cls
grep -v "can't find" %temp%\output.txt

del %temp%\output.txt