@ECHO OFF
REM	dmaurer@opentext.com	03/06/09  - specifically checks to see if llserver is hung in a 'stopping' state and restarts Livelink34 services 
REM	amurray@opentext.com	12/31/08

REM Set server and service name
set llserver=Livelink34
set lladmin=Livelink34Admin

REM Get current state of llserver Process
FOR /f "tokens=2 delims=: " %%i IN  ('SC query %llserver% ^| find "STATE"') DO  SET state=%%i

REM If the service is 'stopping' wait 90 seconds to see if it stops on its own
IF %state% == 3  ( SLEEP 90 ) ELSE ( 
	@ECHO Livelink34 service is either running or stopped; this is OK
	goto end )

REM Get current state of llserver Process again
FOR /f "tokens=2 delims=: " %%i IN  ('SC query %llserver% ^| find "STATE"') DO  SET state=%%i

REM If the service is still 'stopping' we need to kill to process
IF %state% == 3  (

	FOR /f "tokens=2 delims=: " %%i IN ('SC queryex %llserver% ^| find "PID"') DO SET ID=%%i
	SLEEP 30 
	TASKKILL /F /S %server% /PID %ID% 
	SLEEP 5
	EXIT
	
	)

REM Check again to make sure the service is stopped
FOR /f "tokens=2 delims=: " %%j IN ('SC query %llserver% ^| find "STATE"') DO SET test=%%j 


REM This means the service is stopped and we can start it again
IF %test% == 1 (SC start %llserver% EXIT )

REM This means the service is started already so don't do anything
IF %test% == 4  (EXIT) 

REM ** Check to see lladmin service is running
FOR /f "tokens=2 delims=: " %%i IN ('SC query %lladmin% ^| find "STATE"') DO SET fstate=%%i 

REM If service is stopped, start the service
IF %fstate% == 1 (SC start %lladmin% EXIT ) 


REM Wait 10 seconds to confirm the service has started
SLEEP 10 
FOR /f "tokens=2 delims=: " %%i IN ('SC query %llserver% ^| find "STATE"') DO SET fstate=%%i 

IF %fstate% == 4 (@ECHO 0) ELSE (@ECHO 1) 

:end