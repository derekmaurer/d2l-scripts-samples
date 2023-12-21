@ECHO OFF
REM	modified by dmaurer@opentext.com	03/06/09
REM	amurray@opentext.com			12/31/08

REM Set server and service name
@if "%2"=="" goto usage
set server=%1
set llserver=%2
echo %1

REM Get current state of Process
FOR /f "tokens=2 delims=: " %%i IN  ('SC \\%server% query %llserver% ^| find "STATE"') DO  SET state=%%i

IF %state% == 1 (SC \\%server% start %llserver% ) ELSE (SC \\%server% stop %llserver%) 


SLEEP 90

REM Check after 1 min to make sure the service is stopped
FOR /f "tokens=2 delims=: " %%j IN ('SC \\%server% query %llserver% ^| find "STATE"') DO SET test=%%j 


REM This means the service is stopped and we can start it again
IF %test% == 1 (SC \\%server% start %llserver% EXIT )

REM This means the service is hung in the 'stopping' mode and needs to be killed
IF %test% == 3  (
	FOR /f "tokens=2 delims=: " %%i IN ('SC \\%server% queryex %llserver% ^| find "PID"') DO SET ID=%%i
	SLEEP 30 
	TASKKILL /F /S %server% /PID %ID% 
	SLEEP 5
	EXIT
	)

REM This means the service is started already so don't do anything
IF %test% == 4  (EXIT) 


SLEEP 10 
FOR /f "tokens=2 delims=: " %%i IN ('SC \\%server% query %llserver% ^| find "STATE"') DO SET fstate=%%i 

IF %fstate% == 4 (@ECHO 0) ELSE (@ECHO 1) 

goto end

:usage
echo. 
echo Usage:
echo %0 {servername} {servicename}
echo.


:end
