#Export-EventsToCSV
#Convert-evtx

<# 
 .Synopsis
  Export-EventsToCSV exports eventlogs into csv files.

 .Description
  Exports an eventlog into csv file which are easier to process to 
  external tools.  Prevents duplicate events from being exported by remembering the 
  last runtime (as acurately as possible).  Adds Username to the export where UserID is a SID
  in the event.  NOTE: This does not bypass any security restrictions; this must be run with appropriate 
  permissions to the eventlogs and filesystem provided.

 .Parameter Path
  The path used to process and export eventlogs and save the lastrun 'tick' files for sebsequent runs.

 .Parameter Eventlog
  Name of the eventlog to be processed.

 .Parameter EventLogList
  Name of a file that list eventlogs to be processed (one per line).

 .Example
   # Process SYSTEM eventlog and export to csv using the folder "C:\EventsToCSV"
   Export-EventsToCSV -Path "C:\EventsToCSV -Eventlog SYSTEM

 .Example
   # Process eventlogs in .\MyEventLogs.txt and export all to csv using the folder "C:\EventsToCSV"
   Export-EventsToCSV -Path "C:\EventsToCSV -EventLogList .\MyEventLogs.txt

#>

function Export-EventsToCSV {
param(
    [parameter(Mandatory=$true)][string]$Path,
    [parameter(Mandatory=$false)][string]$Eventlog,
    [parameter(Mandatory=$false)][string]$EventlogList
    )

if ( ((!$Eventlog) -and (!$EventlogList)) -or (($Eventlog) -and ($EventlogList)) ){
    Write-host " Error: Export-EventsToCSV requires either -EventLog or -EventLogList ONLY. " -ForegroundColor Yellow
    Break }

# Setup variables
if ($Eventlog) { 
   $winevents = $Eventlog 
   write-verbose $winevents 
   }
if ($EventlogList) { 
   $winevents = (Get-Content -path $EventlogList) 
   write-verbose $winevents 
   }

$event2csvrootpath = $Path
$timestamp = (Get-Date -Format FileDateTimeUniversal )
$logpath = $event2csvrootpath +"\eventlogs\"
$exportpath = $event2csvrootpath +"\export\"
$tickspath = $event2csvrootpath +"\ticks\"

# Cleanup eventlog folder before starting to process eventlogs
rm $logPath.trim() -Recurse -ErrorAction SilentlyContinue

# Create folder if they don't already exist
if ( -Not (Test-Path $logPath )) { New-Item -Path $logPath -ItemType Directory | Out-Null }
if ( -Not (Test-Path $exportpath )) { New-Item -Path $exportpath -ItemType Directory | Out-Null }
if ( -Not (Test-Path $tickspath )) { New-Item -Path $tickspath -ItemType Directory | Out-Null }

write-host "Exporting logs to CSV " -ForegroundColor Yellow -NoNewline

foreach ($winevent in $winevents) {  

# Setup variable for current eventlog 
   $wineventname = ($winevent -replace "/","_")   # replacing / in eventlog name to make if filename friendly 
   $wineventfile = $timestamp + "_" + $wineventname + ".evtx"
   $wineventpath = $logpath + $wineventfile
   $tickpath = ($tickspath + $wineventname) + ".ticks"   # Get 'tick' from previous eventlog process of the same name    if (Test-Path $tickpath) { $ticks = (Get-Content $tickpath) } else { $ticks = 0 }   # export events with wevtutil so service events can be processed   try {      $newtick = (get-date).ticks   # record new 'tick' but don't overwrite the old one incase something fails      wevtutil epl $winevent $wineventpath
      write-host "." -NoNewline -ForegroundColor Yellow
   } catch { Write-host "x" -ForegroundColor Red -NoNewline } 

   # convert the exported evtx file into CSV with some processing
   try {
      $events = convert-evtx -Eventlog $wineventpath -Ticks $ticks
      $csvpath = $exportpath + $timestamp + "_" + $wineventname + ".csv"

      if ($events) { 
        $events | Export-Csv -Path $csvpath 
        Write-Host "." -NoNewline -ForegroundColor Yellow
        echo $newtick > $tickpath    # save the new 'tick' for next run
        } else { Write-Host "." -NoNewline -ForegroundColor DarkYellow }

   } catch { Write-host "X" -ForegroundColor Red -NoNewline} 
   
   write-host ">" -NoNewline -ForegroundColor Yellow
} 

Write-Host " Complete!" -ForegroundColor Green

}

function Convert-EVTX {
param(
    [parameter(Mandatory=$true)][string]$Eventlog,
    [parameter(Mandatory=$false)][string]$Ticks
    )
    $event=$null
    if (!$ticks) { $ticks = 0 } 

    # import evtx file but only new records since last 'tick'
    $events = Get-WinEvent -FilterHashtable @{StartTime=([int64]($Ticks)|Get-Date);Path=$Eventlog } -ErrorAction SilentlyContinue
   
    foreach ($event in $events) {
        $event.message = $event.message -replace "`n|`r"," "    # remove carridge returns so CSV look right    

       # lookup UserID SID and add UserName to make the event more useful on its own
       if ($event.userid -ne $null) { 
          $objSID = New-Object System.Security.Principal.SecurityIdentifier($event.userid);
          $objUser = $objSID.Translate([System.Security.Principal.NTAccount]);
          $event | Add-member UserName $objUser
       } 
    } 
     
    return $events
}

function Gzip-File {
param (
    [String]$inFile = $(throw “Gzip-File: No filename specified”),
    [String]$outFile = $($inFile + “.gz”)
    );

trap {
    Write-Host “Received an exception: $_. Exiting.”;
    break;  }

if (!(Test-Path $inFile)) {
    “Input file $inFile does not exist.”;
    exit 1; }

Write-Host “Compressing $inFile to $outFile.”;
$input = New-Object System.IO.FileStream $inFile, ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::Read);
$output = New-Object System.IO.FileStream $outFile, ([IO.FileMode]::Create), ([IO.FileAccess]::Write), ([IO.FileShare]::None)
$gzipStream = New-Object System.IO.Compression.GzipStream $output, ([IO.Compression.CompressionMode]::Compress)

try {
$buffer = New-Object byte[](1024);
    while($true) {
        $read = $input.Read($buffer, 0, 1024)
        if ($read -le 0) {
            break; }
        $gzipStream.Write($buffer, 0, $read) } 
} finally {
    $gzipStream.Close();
    $output.Close();
    $input.Close();
    } 
}
