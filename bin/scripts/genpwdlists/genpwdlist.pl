#!c:\perl\bin
#
# genpwdlist.pl
#
# Description:
# Builds quarterly password lists for sites listed in eloquent.txt, las.txt, livelink.txt, schawklivelink.txt
#
# Relies on code borrowed from genpass.pl to generate 'strong' passwords incorperated into two sub routines:
# genpass() and genpasslite() both accept an argument for length of password.
#
# History:
#
# 1.0 			dmaurer@opentext.com	2008/06/25
# -initial build
#
# 1.1			dmaurer@opentext.com	2008/10/14
# -genpassarg accepts 3 parms
#	(length of password, enable light password, enable first character not a number)
#
# 1.2
# -removed elink password generation (no longer applicable)
#
# 1.21
# -modified password generation to prevent duplicate characters in sequence
#
#################

open (ENTLIVELINKLIST, "< livelink.txt");
print ("\nEnterprise Series Livelink Production Sites\n");
while (<ENTLIVELINKLIST>){
	$site=$_;
	chop($site);
	print ("  ".$site."\tid= Admin\t pwd= ".genpassarg(14,0,1)."\n");
	print ("  ".$site."\tid= webadmin\t pwd= ".genpassarg(14,0,1)."\n");
	print ("  ".$site."\tid= monitor\t pwd= ".genpassarg(14,0,1)."\n");
	print ("  ".$site."\tid= otmonitor\t pwd= ".genpassarg(14,0,1)."\n");
#	print ("  ".$site."\tid= elink\t pwd= ".genpassarg(14,0,1)."\n");
	print("\n");
	}
close (ENTLIVELINKLIST);

open (ELOQUENTLIST, "< eloquent.txt");
print ("\nEloquent Launchforce\n");
while (<ELOQUENTLIST>){
	$site=$_;
	chop($site);
	if ( $site eq "ehlfod48.b2bscene.com" ) {
		print ("  ".$site."\tid= encoder_OT\t pwd= ".genpassarg(12,1,0)."\n");
		} else {
		print ("  ".$site."\tid= Admin\t pwd= ".genpassarg(12,1,0)."\n");
		}
	endif ;
	}
close (ELOQUENTLIST);

open (LAS, "< las.txt");
print ("\n# LAS Application User Passwords\n");
print ("User    Password        Schema  Description\n");
print ("-------------------------------------------\n");
while (<LAS>){
	$site=$_;
	chop($site);
	print (" admin \t".genpassarg(12,1,0)." \t".$site."\n");
	}
close (LAS);

open (LAS, "< las.txt");
print ("\n");
while (<LAS>){
	$site=$_;
	chop($site);
	print (" monitor \t".genpassarg(12,1,0)." \t".$site."\n");
	}
close (LAS);

open (MEETINGZONE, "< meetingzone.txt");
print ("\n\nMeetingzone Server (LAS)\n");
while (<MEETINGZONE>){
	$site=$_;
	chop($site);
	print ("  ".$site."\tid= Admin\t pwd= ".genpassarg(12,0,0)."\n");
	}
close (MEETINGZONE);

sub genpassarg {

#print $_[0]." ".$_[1]." ".$_[2] ;
	
	if ( $_[1] == 1 ) { 
		$specrange = '-_:.*\(\)!~\[\]\#\^';
	} else {
		$specrange = '-_:;?><.*\(\)+=!~\[\]%@\#\^\{\}&\$';
	}

	$range = "[a-hjkmnp-zA-HJ-NP-Z2-9$specrange]";
	$rangenonum = "[a-hjkmnp-zA-HJ-NP-Z$specrange]";

	my $numpass = 1;
	my $numchars = $_[0];
	my $minnum = 1, $maxnum = 1 + ($numchars/8), $minspec = 1, $maxspec = 1 + ($numchars/8), $minlow = 1, $minupper = 1;

	$randstr = "";
	for ($i=0; $i<$numpass; $i++) {
	    do {
		$nums = 0, $specs = 0, $lows = 0, $uppers = 0;
		$randstr = "";
		for ($randcount = 0; $randcount < $numchars ; $randcount += 1) {
		    do {
			
			if ($randcount == 0 and $_[2] == 1) { 
				do {
				    $value = chr (int (rand 127));
				} while ($value !~ /$rangenonum/);
			} else {  
				do {
					$value = chr (int (rand 127));
				} while ($value !~ /$range/);
			}
			
			$isnum = $value =~ /\d/ ? 1 : 0;
			$isspec = $value =~ /[$specrange]/ ? 1 : 0;
			$islow = $value =~ /[a-z]/ ? 1 : 0;
			$isupper = $value =~ /[A-Z]/ ? 1 : 0;
		    } while ((($nums + $isnum) >= $maxnum) &&
			     (($specs + $isspec) >= $maxspec)); 
		    $nums += $isnum;
		    $specs += $isspec;
		    $lows += $islow;
		    $uppers += $isupper;
		    $randstr = $randstr . $value;
		}
	    } while (($nums < $minnum) ||
		     ($nums > $maxnum) ||
		     ($specs < $minspec) ||
		     ($specs > $maxspec) ||
		     ($lows < $minlow) ||
		     ($uppers < $minupper) ||
		     ($randstr !~ /$lastrandstr/));
	    return  ($randstr);
	    $lastrandstr = $randstr ;
	    
	}
}
