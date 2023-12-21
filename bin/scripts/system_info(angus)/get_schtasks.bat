REM ************************************************
REM * NAME: Get Server INFO
REM * CREATED: Sept 21, 2007 by amurray 
REM * LAST MODIFIED: Sept 21, 2007
REM * MODIFIED BY: amurray
REM * DESCRIPTION:
REM * 
REM *
REM ************************************************


SET TempFile=C:\bin\system_info\prod_servers_schtasks.txt

REM this retrieves schedule task information
ECHO %1 >> %TempFile%
schtasks /query /s %1 /FO TABLE >> %TempFile%
ECHO ***  >> %TempFile%
