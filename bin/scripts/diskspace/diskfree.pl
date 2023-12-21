##########
#	diskfree.pl
#
#	Check free disk space for path (local or UNC)
#	
#	Usage:  diskfree.pl [drive path]
#	ie	diskfree.pl c:\
#		diskfree.pl \\janis\d$
#
#	Note: to check remote path the script must be run in a user context with rights to the resource.
#
#	dmaurer@opentext.com 
#	6/8/2005
#

$numarg=$#ARGV ;
$path = $ARGV[0];

open(OUTPUT, "-|",  "cmd /c dir ".$path);

while (<OUTPUT>) {

        if ($_ =~ /.*Dir\(s\).*/ ) {

                $freeline=$_ ;

		$freeline =~ s/^.*\(s\)*//;	# strip everything before and including (s)
		$freeline =~ s/bytes.*$//;	# strip everything after and including bytes
		$freeline =~ s/[ \t]*//g;	# strip all white space
		$freeline =~ s/\,//g;		# remove , from number

		print $freeline ;

               }

}

close(OUTPUT);



