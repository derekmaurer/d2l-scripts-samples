@echo off
for /f "tokens=1-7 delims=," %%a in (instances.txt) do (
	if %%a=="" goto eof: 
	if %%b=="" goto eof:  
	if %%c=="" goto eof: 
	if %%d=="" goto eof: 
	if %%e=="" goto eof: 
rem	if %%f=="" goto eof: 
rem	if %%g=="" goto eof: 

	echo Processing %%a - %%b

rem	curl -s -k "%%c/d2l/lp/auth/login/login.d2l" -d "userName=%%f&password=%%g" -c output\%%a.%%b.cookie >nul
	curl -s -k "%%c/d2l/lp/systemhealth?token=%%d" > output\%%a.%%b.systemhealth
	curl -s -k "%%c/d2l/common/admin/jobs/?format=json&token=%%e" > output\%%a.%%b.jobs
	curl -s -k "%%c/d2l/common/admin/queues/xml?token=%%e" > output\%%a.%%b.queues

)


