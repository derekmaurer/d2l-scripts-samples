foreach ($hostname in get-content .\hostnames.txt) 
	{
		$ServerName = $hostname.ServerName
		$ping = new-object System.Net.NetworkInformation.Ping
	try {
		$Reply = $ping.send($hostname)
	} catch {
		write-host "Unresponsive,$hostname,na,na" -ForegroundColor "Red"
	}
		if (!$?) {
		
		} elseif ($Reply.status -eq "Success"){
		
			.\check-sslcert-2.ps1 -ipaddr $hostname -port 443
			
		}

	}
