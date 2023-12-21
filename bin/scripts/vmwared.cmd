@echo off 
goto %1

:start
sc start VMAuthdSERVICE
sc start VMnetDHCP
sc start "VMware NAT Service"
sc start vmserverdWin32
sc start vmount2
goto end

:stop
sc stop VMAuthdSERVICE
sc stop VMnetDHCP
sc stop "VMware NAT Service"
sc stop vmserverdWin32
sc stop vmount2
goto end

:end
