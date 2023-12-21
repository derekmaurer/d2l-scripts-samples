#!d:\Perl\bin\perl.exe -w

#######################################################
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
	print ("...Done!\n");
	close(ACTFILE);
	$objlistline++;	
	$linenumber=0;
} until ($objlistline == $objcount);

close(OBJECTLIST);
close(ACTFILE);
close(FILTER);


