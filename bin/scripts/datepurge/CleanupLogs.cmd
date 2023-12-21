@echo off
REM	dmaurer@opentext.com	11:36 AM 2/25/2005

if {%1}=={} goto :usage
if {%2}=={} goto :usage

FORFILES -p%1 -s -m*.* -d-%2 -c"CMD /C del @FILE"
goto :eof

:usage
echo .
echo ..
echo USAGE Notes:
echo ..
echo This script deletes old all files in the specified directory
echo which are older than the specified number of days.
echo Argument #1 is MANDATORY and must specify a working directory
echo (The Location to delete old files)
echo Argument #2 is also MANDATORY and must specify the number of days
echo which must have expired from a file's last modification date
echo for the file to be deleted.
echo ..
echo .
