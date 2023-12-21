--DROP TABLE #jobslastrun
SET NOCOUNT ON
DECLARE @job_id AS uniqueidentifier

CREATE TABLE #jobslastrun (
	  [name] sysname,
	  run_status int,	  
	  last_run varchar(50),
      next_run varchar(50), 
      [server] sysname) 

DECLARE jobids CURSOR
	FOR
		SELECT job_id FROM sysjobs
		ORDER BY [name]
OPEN jobids

FETCH NEXT FROM jobids INTO @job_id
WHILE (@@FETCH_STATUS = 0) 
BEGIN

INSERT INTO #jobslastrun
select top 1 sj.[name], sjh.run_status,   
	convert(datetime, dateadd(mi, (sjh.run_time/100)%100, 
		dateadd(hh, sjh.run_time/10000, cast(sjh.run_date as varchar(50))))) As Last_Run
	, 
convert(datetime, dateadd(mi, (sjs.next_run_time/100)%100, 
		dateadd(hh, sjs.next_run_time/10000, cast(sjs.next_run_date as varchar(50))))) As Next_Run
	, sjh.server
	FROM sysjobhistory sjh
	INNER JOIN sysjobs sj
	ON sj.job_id = sjh.job_id
	INNER JOIN sysjobschedules sjs
	ON sj.job_id = sjs.job_id
	WHERE sj.job_id = @job_id
	order by sjh.run_date desc, sjh.run_time desc

	FETCH NEXT FROM jobids INTO @job_id
END 
CLOSE jobids
DEALLOCATE jobids 

SELECT * FROM #jobslastrun

SET NOCOUNT OFF