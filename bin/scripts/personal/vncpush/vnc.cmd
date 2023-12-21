@ECHO OFF

IF "%2" == "" GOTO SYNTAX
IF "%2" == "/INSTALL" GOTO INSTALL
IF "%2" == "/install" GOTO INSTALL
IF "%2" == "/REMOVE" GOTO REMOVE
IF "%2" == "/remove" GOTO REMOVE
IF "%2" == "/QUERY" GOTO QUERY
IF "%2" == "/query" GOTO QUERY
IF "%2" == "/START" GOTO START
IF "%2" == "/start" GOTO START
IF "%2" == "/STOP" GOTO STOP
IF "%2" == "/stop" GOTO STOP
IF "%2" == "/connect" GOTO CONNECT
IF "%2" == "/CONNECT" GOTO CONNECT

GOTO SYNTAX 

:INSTALL

regini -m \\%1 winvnc.ini>nul: 2>&1

IF NOT EXIST \\%1\ADMIN$\SYSTEM32\WINVNC.EXE COPY WINVNC.EXE \\%1\ADMIN$\SYSTEM32 >nul
IF NOT EXIST \\%1\ADMIN$\SYSTEM32\VNCHOOKS.DLL COPY VNCHOOKS.DLL \\%1\ADMIN$\SYSTEM32 >nul
IF NOT EXIST \\%1\ADMIN$\SYSTEM32\OMNITHREAD_RT.DLL COPY OMNITHREAD_RT.DLL \\%1\ADMIN$\SYSTEM32 >nul

SC.EXE \\%1 CREATE winvnc binpath= WinVNC.exe type= share start= demand obj= LocalSystem displayname= "VNC Server" type= interact > %TEMP%\WINVNC.TMP

FIND "SUCCESS" %TEMP%\WINVNC.TMP >NUL
IF ERRORLEVEL 1 GOTO NOSERVICE
ECHO ----------------------------
ECHO Service Created successfully
ECHO ----------------------------
GOTO INSTALLED

:NOSERVICE
FIND "1073" %TEMP%\WINVNC.TMP >NUL
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
regini -m \\%1 service.ini>nul: 2>&1

sc \\%1 start winvnc > %TEMP%\WINVNC.TMP
FIND "START_PENDING" %TEMP%\WINVNC.TMP >NUL
IF ERRORLEVEL 1 GOTO RUNNING
FIND "RUNNING" %TEMP%\WINVNC.TMP >NUL
IF ERRORLEVEL 1 GOTO RUNNING
ECHO Service did not Start
ECHO -----------------------
:RUNNING
ECHO Service Started
ECHO ----------------------------
SLEEP 5
@CHOICE Connect to %1 Now 
@IF ERRORLEVEL 2 GOTO END
START VNCVIEWER %1:0
GOTO END


:REMOVE

SC \\%1 STOP WINVNC >NUL
SC \\%1 DELETE WINVNC > %TEMP%\WINVNC.TMP
FIND "SUCCESS" %TEMP%\WINVNC.TMP >NUL
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
DEL \\%1\ADMIN$\SYSTEM32\OMNITHREAD_RT.DLL >NUL 2>NUL
DEL \\%1\ADMIN$\SYSTEM32\WINVNC.EXE >NUL 2>NUL
DEL \\%1\ADMIN$\SYSTEM32\VNCHOOKS.DLL >NUL 2>NUL

GOTO END

:CONNECT
start VNCVIEWER %1:0
GOTO END

:SYNTAX
@ECHO /-----------------------------------------------/
@ECHO /  SYNTAX:                                      /
@ECHO / "VNC COMPUTERNAME /INSTALL | /REMOVE /CONNECT /
@ECHO /-----------------------------------------------/
GOTO END

DEL %TEMP%\WINVNC.TMP >NUL
:END

