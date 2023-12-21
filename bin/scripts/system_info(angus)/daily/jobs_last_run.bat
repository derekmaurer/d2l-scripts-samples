SET dd=%date:~7,2%
SET mm=%date:~4,2%
SET yyyy=%date:~10,4%

sqlcmd -E -S ELVIS -d msdb -Y 40 -i  jobs_last_run.sql -o output\elvis_jobs_last_run.log 

SLEEP 3

c:\bin\blat.exe  output\elvis_jobs_last_run.log -s "%yyyy%_%mm%_%dd% %time%- Scheduled Jobs On Elvis"   -to amurray@opentext.com