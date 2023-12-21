# ***********************************************************
# Part 1: Get an appropriate list of servers we can work with 
# ***********************************************************

# require a command line argument so script isn't accidently run
eval($ARGV[0]=~ /run/) or die "You must run script with a command line argument"; 

#This gets the list of servers on the windows domain
system ('dsquery computer -name * | dsget computer -samid > output\windows_servers.txt');

# Uses three files, one for the raw list, one for the servers we can access, 
# and one for the servers that can't be accessed (unavailable) 
$serverlist = "output\\windows_servers.txt";
$serverlistmod = ">output\\windows_servers_mod.txt";
$serverunavail = ">output\\windows_servers_unavail.txt";

open (INPUT, $serverlist) || die "Can't open $serverlist: $!";
open (OUTPUT, $serverlistmod) || die "Can't open $serverlistmod: $!";
open (OUTPUT2, $serverunavail) || die "Can't open $serverunavail : $!";

# This section just manipulates the raw server file into two readable
# files	
while (<INPUT>) { 
	
	next if /\s+samid|dsget/;
	$_ =~ s/\$//;		# replaces $ with nothing
	$_ =~ s/^\s+//;		# replaces pre-spaces with nothing
	$_ =~ s/\s+$//;
	chomp $_;
	$testdir = '\\\\' . $_ . '\\c$\\bin\\';
	if( -d $testdir) 
		{ 

		print OUTPUT  $_ . "\n";
		} 
	else{
		print OUTPUT2 $_ . "\n";		
		} 
}
close OUTPUT;
close OUTPUT2;
close $serverunavail;
close $serverlistmod;
close $serverlist;

# This is just to sort the server list alphabetically 
system ('sort output\windows_servers_mod.txt > output\windows_servers_order.txt');