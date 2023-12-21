###  Saving service event to .evtx files
# wevtutil epl Microsoft-Windows-SMBClient/Operational Microsoft-Windows-SMBClient.Operational.xml
$winevents = @("Microsoft-Windows-SMBClient/Operational",
             "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational")

$timestamp = Get-Date -Format FileDateTIme
$logpath = "c:\temp\wevt\eventlogs\"
$exportpath = "C:\temp\wevt\export\"
$processedpath = "C:\temp\wevt\processed\"

$bookmarksfile = "C:\temp\wevt\bookmarks.csv"

if ( -Not (Test-Path $logPath.trim() )) { New-Item -Path $logPath -ItemType Directory | Out-Null }
if ( -Not (Test-Path $exportpath.trim() )) { New-Item -Path $exportpath -ItemType Directory | Out-Null }
if ( -Not (Test-Path $processedpath.trim() )) { New-Item -Path $processedpath -ItemType Directory | Out-Null }
if ( -Not (Test-Path $bookmarksfile )) { Set-Content $bookmarksfile -Value "TimeStamp,Eventlog,Base,LastTime" ; add-content $bookmarksfile -value "0,0,0,0" | Out-Null }

$bookmarks = @()
$bookmarks += import-csv $bookmarksfile

foreach ($winevent in $winevents) {  

   $logtick = (get-date).Ticks
   
   $wineventbase = ($winevent -replace "/","_")
   $wineventpath = $logpath + $timestamp + "_" + $wineventbase + ".evtx"
      wevtutil epl $winevent $wineventpath

   if ( ($bookmarks | where Eventlog -eq $winevent | measure) -eq 0 ) { 
        $bookmark = "TimeStamp,Eventlog,Base,LastTime","$logtick,$winevent,$wineventbase,0" | convertfrom-csv
        $bookmarks += $bookmark
        } else {
        foreach ($line in $bookmarks) { 
            where $line.Eventlog -eq $winevent 
                $line.LastTime = $line.TimeStamp 
                $line.TimeStamp = $logtick 
                $line.Base = $wineventbase 
                }
        }
   }
}

$bookmarks | Export-Csv $bookmarksfile

### Writes Eventlog to CSV file
# get specified eventlog

$evtlogs = Get-ChildItem $logpath

write-host "Exporting logs to CSV " -ForegroundColor Yellow -NoNewline
try {
foreach ($evtlog in $evtlogs) {

    $evtlogpath = ($logpath + $evtlog.Name)
    $evtlogprocessedpath = ($processedpath + $evtlog.Name)
    $csvpath = ($exportpath + $evtlog.BaseName + ".csv")
    $evtlogbase = $evtlog.Name.Substring(20) ; $evtlogbase = $evtlogbase.substring(0,$evtlogbase.Length-5)
    $bookmark = ($bookmarks | where Base -eq $evtlogbase)
    
    $events = (Get-WinEvent -Path $evtlogpath | where TimeCreated -gt ($bookmark.LastTime|get-date))

    # strips carriage returns from human readable 'message' field
    foreach ($event in $events) {
        $event.message = $event.message -replace "`n|`r"," "        # remove carridge returns from event messages

       # insert .username so events are meaningful without querying AD
       if ($event.userid -ne $null) { 
          $objSID = New-Object System.Security.Principal.SecurityIdentifier($event.userid);
          $objUser = $objSID.Translate([System.Security.Principal.NTAccount]);
          $event | Add-member UserName $objUser
       }
    } 
    
    $events | Export-Csv -Path $csvpath
    Write-Host "." -NoNewline

#    Write-Host " "
#    Write-Host "Move-Item -path $evtlogpath -Destination $evtlogprocessedpath" -ForegroundColor Gray
#    Move-Item -path $evtlogpath -Destination $evtlogprocessedpath
#    C:\bin\sysinternals\handle.exe | findstr /i C:\temp

}
 
Write-Host " SUCCESS" -ForegroundColor Green

} catch { Write-Host "Something went wrong :(" -ForegroundColor Red }