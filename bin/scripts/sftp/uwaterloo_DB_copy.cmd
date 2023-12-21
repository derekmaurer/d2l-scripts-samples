rem set sourcepath=V:\IT_Manual_Backups\FULL\uWaterloo
set sourcepath=C:\bin\scripts\sftp_uwaterloo
set log=C:\bin\scripts\sftp_uwaterloo\uwaterloosftp.log
set scriptpath=C:\bin\scripts\sftp_uwaterloo
set sftp=hostname=www.themaurers.ca
set sftpusername=dmaurer
set sftpscript=C:\bin\scripts\sftp_uwaterloo\sftpuwaterloo.script

for /f %%g IN ('dir /b /o-d %sourcepath%\uwaterloo_backup_%date:~10,4%_%date:~7,2%_%date:~4,2%*.bak') DO (
	set sourcefile=%%g
	goto buildscript
	)

:buildscript
echo put %sourcefile% > tail
copy %scriptpath%\head + tail %sftpscript%
del /y tail

:sftp
echo ========================= >> %log%
echo %date% >> 
echo Starting SFTP transfer... >> %log%

psftp %username%@%hostname% -b %sftpscript% >> %log%

