@echo off

FOR /F %%i IN (paths.txt) DO (
	echo %%i >> dir.txt
	dir /b %%i >> dir.txt
	)


