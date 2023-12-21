REM ************************************************
REM * NAME: Get Server INFO
REM * CREATED: Sept 21, 2007 by amurray 
REM * LAST MODIFIED: Sept 21, 2007
REM * MODIFIED BY: amurray
REM * DESCRIPTION:
REM * 
REM *
REM ************************************************


SET TempFile2=C:\bin\system_info\servers_info.txt

REM this gets all information about a server. Only for Win2003
systeminfo /s %1 /FO CSV /NH >> %TempFile2%



