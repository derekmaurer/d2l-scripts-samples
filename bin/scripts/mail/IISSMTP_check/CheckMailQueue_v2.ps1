<#
   This script checks the server provided for old messages in the IIS .\mail\queue folders
#>

function Usage(){
	Write-Host Usage: $MyInvocation.scriptname servername
}

if($args.Count -eq 0){
      Usage
      exit(1)
}
	
# $mailpath = "\\t1mail36.tor01.desire2learn.d2l\d$\Desire2Learn\mail"
$mailpath = "\\" + $args[0] + "\d$\Desire2Learn\mail"
$showgood = 1
$showmissing = 1

foreach($_ in ( Get-ChildItem $mailpath )) {
	
	if (Test-Path $mailpath\$_\queue ) {
		$WaitingMail = Get-ChildItem $mailpath\$_\queue | Where-Object {$_.lastwritetime -lt (Get-Date).AddMinutes(-15)}
		if ($showgood -eq 1 ) {
		Write-Host $_ : $WaitingMail.count -ForegroundColor green
		} elseif ($showgood -eq 0 -and $WaitingMail.count -gt 0 ) {
		Write-Host $_ : $WaitingMail.count -ForegroundColor green
		} elseif ( $showmissing -eq 1 ){
		Write-Host $_ : $mailpath$_\queue Does Not Exist -ForegroundColor yellow
		}
	}
}
exit(1)

