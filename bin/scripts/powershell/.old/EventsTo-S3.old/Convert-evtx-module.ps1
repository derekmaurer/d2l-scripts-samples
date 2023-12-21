
function convert-evtx {

param(
    [parameter(Mandatory=$true)][string]$Path,
    [parameter(Mandatory=$true)][string]$Eventlog
    )

    # import the evtx file but only new records since last 'tick'
    $events = (Get-WinEvent -Path $file | where TimeCreated -gt ([int64]($ticks)|Get-Date)) 

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