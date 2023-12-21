mstsc /w:1280 /h:800  /v:Web16f
mstsc /w:1280 /h:800  /v:Web16g
mstsc /w:1280 /h:800  /v:Web16h


Web16f
Web16g
Web16h



wuauclt /detectnow 


powershell D:\Desire2Learn\BIN\Recycle\Recycle.ps1 all



reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate /V SusClientId /F
net stop wuauserv
net start wuauserv
wuauclt.exe /resetauthorization
wuauclt.exe /detectnow
wuauclt.exe /reportnow

Microsoft FixIt
http://support.microsoft.com/kb/971058

regsvr32 /u msxml3.dll
regsvr32 msxml3.dll


?[05/02/12,13:39:27] Microsoft .NET Framework 2.0a: [2] Error: Installation failed for component Microsoft .NET Framework 2.0a. MSI returned error code 1612
[05/02/12,13:39:58] Microsoft .NET Framework 3.0 SP2 x86: [2] Error: Installation failed for component Microsoft .NET Framework 3.0 SP2 x86. MSI returned error code 1612
?[05/02/12,13:39:27] Microsoft .NET Framework 2.0a: [2] Error: Installation failed for component Microsoft .NET Framework 2.0a. MSI returned error code 1612
[05/02/12,13:39:58] Microsoft .NET Framework 3.0 SP2 x86: [2] Error: Installation failed for component Microsoft .NET Framework 3.0 SP2 x86. MSI returned error code 1612
[05/02/12,13:40:23] WapUI: [2] DepCheck indicates Microsoft .NET Framework 2.0a is not installed.
[05/02/12,13:40:23] WapUI: [2] DepCheck indicates Microsoft .NET Framework 3.0 SP2 x86 is not installed.
[05/02/12,13:44:22] Microsoft .NET Framework 2.0a: [2] Error: Installation failed for component Microsoft .NET Framework 2.0a. MSI returned error code 1612
[05/02/12,13:44:36] Microsoft .NET Framework 3.0 SP2 x86: [2] Error: Installation failed for component Microsoft .NET Framework 3.0 SP2 x86. MSI returned error code 1612
