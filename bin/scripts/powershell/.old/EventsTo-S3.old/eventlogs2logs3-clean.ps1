

#export-events2csv

$winevents = @("Microsoft-Windows-SMBClient/Operational",
             "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational")

$event2csvrootpath = "c:\temp\wevt\"
$timestamp = (Get-Date -Format FileDateTimeUniversal )
$logpath = $event2csvrootpath +"eventlogs\"
$exportpath = $event2csvrootpath +"export\"
$tickspath = $event2csvrootpath +"ticks\"

rm $logPath.trim() -Recurse -ErrorAction SilentlyContinue
if ( -Not (Test-Path $logPath )) { New-Item -Path $logPath -ItemType Directory | Out-Null }
if ( -Not (Test-Path $exportpath )) { New-Item -Path $exportpath -ItemType Directory | Out-Null }
if ( -Not (Test-Path $tickspath )) { New-Item -Path $tickspath -ItemType Directory | Out-Null }

write-host "Exporting logs to CSV " -ForegroundColor Yellow -NoNewline

foreach ($winevent in $winevents) {  

   $wineventname = ($winevent -replace "/","_")
   $wineventfile = $timestamp + "_" + $wineventname + ".evtx"
   $wineventpath = $logpath + $wineventfile
   $tickpath = ($tickspath + $wineventname) + ".ticks"   if (Test-Path $tickpath) { $ticks = (Get-Content $tickpath) } else { $ticks = 0 }   try {      $newtick = (get-date).ticks      wevtutil epl $winevent $wineventpath
      write-host "." -NoNewline -ForegroundColor Yellow
   } catch { Write-host "x" -ForegroundColor Red } 

   try {
      $events = convert-evtx -File $wineventpath -Ticks $ticks
      $csvpath = $exportpath + $timestamp + "_" + $wineventname + ".csv"

      if ($events) { 
        $events | Export-Csv -Path $csvpath 
        Write-Host "." -NoNewline -ForegroundColor Yellow
        echo $newtick > $tickpath
        } else { Write-Host "." -NoNewline -ForegroundColor DarkYellow }

   } catch { Write-host "X" -ForegroundColor Red } 
   
   write-host ">" -NoNewline -ForegroundColor Yellow
} 

Write-Host " Complete!" -ForegroundColor Green

function convert-evtx($File,$Ticks) {

    $events = (Get-WinEvent -Path $file | where TimeCreated -gt ([int64]($ticks)|Get-Date)) 

    foreach ($event in $events) {
        $event.message = $event.message -replace "`n|`r"," "        

       if ($event.userid -ne $null) { 
          $objSID = New-Object System.Security.Principal.SecurityIdentifier($event.userid);
          $objUser = $objSID.Translate([System.Security.Principal.NTAccount]);
          $event | Add-member UserName $objUser
       } 
    } 
     
    return $events
}
