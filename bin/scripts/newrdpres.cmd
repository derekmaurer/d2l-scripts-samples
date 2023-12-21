@echo off 
@if "%2"=="" goto usage
@if "%1"=="yes" goto %2

:usage
@echo Usage: newrdpres.cmd yes res/password
@echo "yes" is needed in order for script to run.
@echo "res" will replace all *.rdp file resolution to 1440/900.
@echo "pwd" will force pwd prompt for all *.rdp files.
goto end

:res
for %i in (*.rdp) do type "%i" | sed s/^desktopwidth*.*./desktopwidth:i:1440/ | sed s/^desktopheight*.*./desktopheight:i:900/  > "%inew"
del *.rdp
ren *.rdp.new *.rdp
goto end

:pwd
for %f in (*.rdp) do type "%f" | sed s/^promptcredentialonce*.*./promptcredentialonce:i:1/ > "%fnew"
del *.rdp
ren *.rdp.new *.rdp
goto end

:end
