$csvfile = "./list.csv"
$dnsserver = "192.168.253.233"

$urlcsv = Import-Csv $csvfile 
foreach ( $urllist in $urlcsv )
	{
	$Hostname = $urllist.Hostname
	$ipaddress = $urllist.ipaddress

	$oldlookup = [System.Net.Dns]::GetHostAddresses("$hostname") | select-object IPAddressToString -expandproperty  IPAddressToString
	
#	echo "dnscmd.exe $dnsserver /zoneadd $Hostname /primary"
	dnscmd.exe $dnsserver /zoneadd $Hostname /primary 2>&1 | Out-Null
	
#	echo "dnscmd.exe $dnsserver /recordadd $Hostname . A $ipaddress"
	dnscmd.exe $dnsserver /recordadd $Hostname . A $ipaddress	2>&1 | Out-Null
	
	$lookup = [System.Net.Dns]::GetHostAddresses("$hostname") | select-object IPAddressToString -expandproperty  IPAddressToString
	if ( $ipaddress = $lookup )
		{
		Write-Host "$hostname,$oldlookup > $lookup		Success!" -foregroundcolor green
		}
	
	
	}
	