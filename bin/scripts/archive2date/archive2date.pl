#c:\perl5\perl

#	author: dmaurer@opentext.com	10:50 AM 3/30/2006

#	title: archive2date.pl
#	use: copy a file from source to destination and rename with date prefix

$numarg=$#ARGV ;

if ( $numarg < 2 ) { 
	print ("\n\nUsage: archive2date.pl source_folder destination_folder source_filename \n ") ;
	print ("eg. archive2date.pl c:\work c:\work.bakup mydocument.txt\n") ;
	exit 65 ; 
	}

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);

$yearplus=$year+1900;
$monplus=$mon+1;

print ("\n\ncopy ".$ARGV[0]."\\".$ARGV[2]." ".$ARGV[1]."\\$yearplus-$monplus-$mday-".$ARGV[2]."\n\n");
system("copy ".$ARGV[0]."\\".$ARGV[2]." ".$ARGV[1]."\\$yearplus-$monplus-$mday-".$ARGV[2]);

