#!e:\Perl\bin\perl.exe

######
# Derek Maurer
# derekmaurer@rogers.com
# 09-06-2002

######
# Adds single route to first PPTP connection automatically
#

$dnetwork="192.168.11.39";  	# destination network
$dmask="255.255.255.0";		# destination network mask

system("ipconfig > ipconfig.tmp");

open(IPCONFIG,"ipconfig.tmp");
while (<IPCONFIG>){ 
	if ($_ =~ /PPP adapter opentext/) { 
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

	system( "route add ".$dnetwork." ".$anotherlist[1]);
	print ("Route set to ".$dnetwork." through".$anotherlist[1]);

} 
	else {
	print ("No PPP connection!");
	}

close (IPCONFIG);

system("del ipconfig.tmp");


