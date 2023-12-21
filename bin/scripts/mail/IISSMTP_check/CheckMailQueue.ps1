<#
.SYNOPSIS
   <A brief description of the script>
.DESCRIPTION
   <A detailed description of the script>
.PARAMETER <paramName>
   <Description of script parameter>
.EXAMPLE
   <An example of using the script>
#>

$mailpath = "\\t1mail36.tor01.desire2learn.d2l\d$\Desire2Learn\mail"

foreach($_ in ( Get-ChildItem $mailpath )) {
	
	if (Test-Path $mailpath\$_\queue ) {
		$WaitingMail = Get-ChildItem $mailpath\$_\queue | Where-Object {$_.lastwritetime -lt (Get-Date).AddMinutes(-15)}
		Write-Host $_ : $WaitingMail.count -ForegroundColor green
		} else {
		Write-Host $_ : $mailpath$_\queue Does Not Exist -ForegroundColor yellow
		}
	}
	