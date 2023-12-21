SET dd=%date:~7,2%
SET mm=%date:~4,2%
SET yyyy=%date:~10,4%

cscript DB_svrs_sch_tasks.vbs

SLEEP 3

c:\bin\blat.exe output\SchTasks_report_DB.txt -s "%yyyy%_%mm%_%dd% %time% - Scheduled Tasks on DB Servers" -to amurray@opentext.com