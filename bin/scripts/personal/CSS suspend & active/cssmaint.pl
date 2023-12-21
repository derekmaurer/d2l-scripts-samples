#!d:\Perl\bin\perl.exe
#
#  This script will take a STARTUP-CONFIG file from a CSS11000 loadbalancer
# and create suspend/activate scripts based on groups defined in OBJECTLIST
#
# NOTE: I'm an awful coder, there ARE better way to do this...
#
# Start 08-03-2002 - Last revision 08-04-2002
#
# Derek Maurer
# dmaurer@opentext.com


#######################################################
# setup work to filter unwanted parts of startup-config





# open the list and temp output file
open(OBJECTLIST, "objectlist")
	or die "Can't open: $!";
open(COMMANDS, ">commands.tmp")
	or die "Can't open: $!";

# build the list of command and write them to a file
while (<OBJECTLIST>){
	chop($_);
	$commandline="grep -E \"" . $_ . "\" startup-config.filtered | grep -v \"add service\" | grep -v \"content\" > " . $_ . ".suspend.tmp";
	print COMMANDS ($commandline . "\n");
}

# cleanup open files
close(COMMANDS);
close(OBJECTLIST);

#
# run the command list (that builds temp files) to build yet another temp file
open(COMMANDLIST, "commands.tmp")
	or die "Can't open: $!";

while (<COMMANDLIST>){
#	print ($_ . "\n");	# uncomment if you want to see output
	system($_);
}

close(COMMANDLIST);



#on to the next part!
###############################

# get our list of list of object for services
open(OBJECTLIST, "objectlist")
	or die "Can't open: $!";

while (<OBJECTLIST>){
	chop($_);


# setup for file creation
$filename= ">" . $_ . ".suspend";
$filename2= $_ . ".suspend";

#display what files are being built
print ("Building ".$filename2."...");
	open(COMPLETEFILE, $filename )
		or die "Can't open: $!";

	# start of CSS script building
	print COMPLETEFILE ("config\n"); # short CSS cmd form used

	open(SERVICE, $filename2 . ".tmp")
		or die "Can't open: $!";

	while (<SERVICE>){
		print COMPLETEFILE ($_);
		print COMPLETEFILE ("sus\n"); # short CSS cmd form used
	}

	# finish it up
	print COMPLETEFILE ("exit\n");

	close(COMPLETEFILE);
	close(SERVICE);

# what files are finished
print ("...Done!\n");
}

print ("\n");
close(OBJECTLIST);

# cleanup .tmp files
system("del *.tmp");


# Build activate scripts based on current state
################################################

# setup work to filter unwanted parts of startup-config

system("grep -E \"service\|active\|OWNER\" startup-config | grep -v add > startup-config.filtered");

$objlistline=0;
$objcount=0;
$linenumber=0;
$objlistline=0;

open(FILTER, "startup-config.filtered")
	or die "Can't open: $!";
open(OBJECTLIST, "objectlist")
	or die "Can't open: $!";

while(<FILTER>){
	push (@templist, $_);
	}

while(<OBJECTLIST>){
	push (@objectlist, $_);
	$objcount++ 
	}
close(OBJECTLIST);

do {
	$check=$objectlist[$objlistline];
	chop($check);

	open (ACTFILE, ">".$check.".activate")
			or die "Can't open: $!";
	print ACTFILE ("config\n"); # short CSS cmd form used
	print ("Building ".$check.".activate ...");
		do {
			$item="$templist[$linenumber]";
			$nextitem="$templist[$linenumber+1]";

#################### check objectlist for services and write file
			if ($item =~ /service/){
				if ($nextitem =~ /active/){
					print ACTFILE $item if $item =~ /$check/;
					print ACTFILE $nextitem if $item =~ /$check/;
					}
				}
		$linenumber++;
		} until ($templist[$linenumber] =~ /OWNER/) ;
	print ACTFILE ("exit\n");
	close(ACTFILE);
	print ("...Done!\n");
	$objlistline++;	
	$linenumber=0;
} until ($objlistline == $objcount);

close(OBJECTLIST);
close(ACTFILE);
close(FILTER);


