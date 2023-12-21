@echo off
FOR /F %%i IN (paths.txt) DO echo "Testfile" >> %%i
