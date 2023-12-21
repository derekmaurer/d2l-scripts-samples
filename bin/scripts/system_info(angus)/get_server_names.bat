REM ************************************************
REM * NAME: Get Server Names
REM * CREATED: Sept 21, 2007 by amurray 
REM * LAST MODIFIED: Sept 21, 2007
REM * MODIFIED BY: amurray
REM * DESCRIPTION:
REM * 
REM *
REM ************************************************


SET TempFile=C:\bin\system_info\servers.txt


REM this gets all the server names in Active Directory 
dsquery computer -name * | dsget computer -samid > %TempFile%

DEL /Q C:\bin\system_info\servers_info.txt