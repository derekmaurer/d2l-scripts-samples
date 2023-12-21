@echo off 

sc query SR_Service | grep RUNNING | sed "s/.*RUNNING.*/stop/g" > %temp%\scremote.tmp

for /F %%f in (%temp%\scremote.tmp) do if "%%f"=="stop" goto :stop

:start
sc start SR_Service
sc start SR_Watchdog
goto end

:stop
sc stop SR_Service
sc stop SR_Watchdog
goto end

:end
del %temp%\scremote.tmp 