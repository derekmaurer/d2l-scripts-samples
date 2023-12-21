#!e:\Perl\bin\perl.exe

######
# Derek Maurer
# derekmaurer@rogers.com
# 09-06-2002

######
# Adds single route to first PPTP connection automatically
#

#$dnetwork="10.2.102.0";  	# destination network
$dnetwork2="172.24.62.0";  	# destination network
$dnetwork3="172.24.68.0";  	# destination network
$dnetwork4="172.24.74.0"; 	# destination network
$dmask="255.255.255.0";		# destination network mask

#zurich networks
$dnetwork5="10.1.1.0"; 		# destination network
$dmask5="255.255.255.0";	# destination network mask
$dnetwork6="10.10.0.0"; 	# destination network
$dmask6="255.255.0.0";		# destination network mask
$dnetwork7="10.143.224.0"; 	# destination network
$dmask7="255.255.240.0";	# destination network mask

#opentext networks
$dnetwork8="10.2.184.11"; 	# destination network
$dmask8="255.255.240.0";	# destination network mask


system("ipconfig > ipconfig.tmp");

open(IPCONFIG,"ipconfig.tmp");
while (<IPCONFIG>){ 
	if ($_ =~ /PPP adapter vpn/) { 
		$pppexists="1";
		last;
	} 
	$count++;	
}

open(IPCONFIG,"ipconfig.tmp");
@lines=<IPCONFIG>;

$line=$count+3;
$newline=$lines[$line];

if ($pppexists =~ /1/) {

	@anotherlist=split (/:/, $newline);

#	system( "route add ".$dnetwork." mask ".$dmask." ".$anotherlist[1]);
#	print ("Route set to ".$dnetwork." through".$anotherlist[1]);

	system( "route add ".$dnetwork2." mask ".$dmask." ".$anotherlist[1]);
	print ("Route set to ".$dnetwork2." through".$anotherlist[1]);

	system( "route add ".$dnetwork3." mask ".$dmask." ".$anotherlist[1]);
	print ("Route set to ".$dnetwork3." through".$anotherlist[1]);

	system( "route add ".$dnetwork4." mask ".$dmask." ".$anotherlist[1]);
	print ("Route set to ".$dnetwork4." through".$anotherlist[1]);

	system( "route add ".$dnetwork5." mask ".$dmask5." ".$anotherlist[1]);
	print ("Route set to ".$dnetwork5." through".$anotherlist[1]);

	system( "route add ".$dnetwork6." mask ".$dmask6." ".$anotherlist[1]);
	print ("Route set to ".$dnetwork6." through".$anotherlist[1]);

	system( "route add ".$dnetwork7." mask ".$dmask7." ".$anotherlist[1]);
	print ("Route set to ".$dnetwork7." through".$anotherlist[1]);

	system( "route add ".$dnetwork8." mask ".$dmask8." ".$anotherlist[1]);
	print ("Route set to ".$dnetwork8." through".$anotherlist[1]);

} 
	else {
	print ("No PPP connection!");
	}

close (IPCONFIG);

system("del ipconfig.tmp");


