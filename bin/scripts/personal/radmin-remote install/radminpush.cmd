@echo off

IF "%2" == "" GOTO SYNTAX
IF "%2" == "/INSTALL" GOTO INSTALL
IF "%2" == "/install" GOTO INSTALL
IF "%2" == "/REMOVE" GOTO REMOVE
IF "%2" == "/remove" GOTO REMOVE
IF "%2" == "/START" GOTO START
IF "%2" == "/start" GOTO START
IF "%2" == "/STOP" GOTO STOP
IF "%2" == "/stop" GOTO STOP

GOTO SYNTAX 

:INSTALL

reg copy HKLM\SYSTEM\RAdmin \\127.0.0.1 HKLM\SYSTEM\Radmin \\%1

IF NOT EXIST \\%1\ADMIN$\SYSTEM32\Admdll.dll COPY Admdll.dll \\%1\ADMIN$\SYSTEM32 >nul
IF NOT EXIST \\%1\ADMIN$\SYSTEM32\raddrv.DLL COPY raddrv.DLL \\%1\ADMIN$\SYSTEM32 >nul
IF NOT EXIST \\%1\ADMIN$\SYSTEM32\visedll.dll COPY visedll.dll \\%1\ADMIN$\SYSTEM32 >nul
IF NOT EXIST \\%1\ADMIN$\SYSTEM32\r_server.exe COPY r_server.exe \\%1\ADMIN$\SYSTEM32 >nul

sc \\%1 create r_server binpath= "r_server.exe /service" type= own start= auto DISPLAYNAME= "Remote Administrator Service" > %TEMP%\radmin.TMP

FIND "SUCCESS" %TEMP%\radmin.TMP >NUL
IF ERRORLEVEL 1 GOTO NOSERVICE
ECHO ----------------------------
ECHO Service Created successfully
ECHO ----------------------------
GOTO INSTALLED

:NOSERVICE
FIND "1073" %TEMP%\radmin.TMP >NUL
IF ERRORLEVEL 1 GOTO UNKNOWN
ECHO ----------------------
ECHO Service Already Exists
ECHO ----------------------
GOTO END

:UNKNOWN
ECHO ------------------------
ECHO Unable to create Service
ECHO ------------------------
GOTO END

:INSTALLED

REM modified image path for service
reg update HKLM\SYSTEM\RAdmin \\127.0.0.1 HKLM\SYSTEM\Radmin \\%1 >nul: 2>&1

sc \\%1 start r_server > %TEMP%\radmin.TMP
FIND "START_PENDING" %TEMP%\radmin.TMP >NUL
IF ERRORLEVEL 1 GOTO RUNNING
FIND "RUNNING" %TEMP%\radmin.TMP >NUL
IF ERRORLEVEL 1 GOTO RUNNING
ECHO Service did not Start
ECHO -----------------------
:RUNNING
ECHO Service Started
ECHO ----------------------------
SLEEP 5
@CHOICE Connect to %1 Now 
@IF ERRORLEVEL 2 GOTO END
START radmin /connect:%1:4899 /locolor
GOTO END


:REMOVE

SC \\%1 STOP r_server >NUL
SC \\%1 DELETE r_server > %TEMP%\radmin.TMP
FIND "SUCCESS" %TEMP%\radmin.TMP >NUL
IF ERRORLEVEL 1 GOTO NOTREMOVED
ECHO ----------------------------
ECHO Service removed successfully
ECHO ----------------------------
GOTO DELETEFILES

:NOTREMOVED
ECHO ---------------------------------------------------
ECHO Unable to remove Service or Service already removed
ECHO ---------------------------------------------------
GOTO END

:DELETEFILES
SLEEP 5
REM PAUSE FOR SERVICE TO STOP BEFORE DELETING FILES OTHERWISE THEY WILL STILL BE IN USE.
DEL \\%1\ADMIN$\SYSTEM32\admdll.dll >NUL 2>NUL
DEL \\%1\ADMIN$\SYSTEM32\raddrv.dll >NUL 2>NUL
DEL \\%1\ADMIN$\SYSTEM32\visedll.dll >NUL 2>NUL
DEL \\%1\ADMIN$\SYSTEM32\r_server.exe >NUL 2>NUL

GOTO END

:CONNECT
START radmin /connect:%1:4899 /locolor
GOTO END

:SYNTAX
@ECHO /------------------------------------------------------/
@ECHO /  SYNTAX:                                             /
@ECHO / "radminpush COMPUTERNAME /INSTALL | /REMOVE /CONNECT /
@ECHO /------------------------------------------------------/
GOTO END

DEL %TEMP%\radmin.TMP >NUL
:END
