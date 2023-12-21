#!c:\perl\perl.exe

#######################
#
# LLadmin_password_verify.pl
#
# Verifies admin and webadmin pwd hashes are consistent across a cluster
# Usage: LLadmin_password_verify.pl sitename serverA serverB <serverC> <serverD>
#
# Requirements: sitename and 2 hosts (servers), max 4 hosts (servers)
#
# Written by:
# Derek Maurer
# dmaurer@opentext.com
# 11:11 AM 2/2/2005
#

# vars
$llrootpath="\\d\$\\opentext\\";
$llconfigpath="\\config\\";
$llini="opentext\.ini";
$lastserver = 0 ;
$numarg=$#ARGV ;
$lastserver = 2 ;
$sitename = $ARGV[0];
$serverA = $ARGV[1];
$serverB = $ARGV[2]; 

# only
if ($numarg > 2) { $lastserver++ ; $serverC = $ARGV[3]; }
if ($numarg > 3) { $lastserver++ ; $serverD = $ARGV[4]; } 


if ( $numarg < 2 || $numarg > 4) { 
	print ("\nUsage: LLadmin_password_verify.pl sitename serverA serverB <serverC> <serverD>" ) ;
	exit 65 ; 
	}
	

#setup opentext.ini file paths
$frontendA="\\\\".$serverA."".$llrootpath."".$sitename."".$llconfigpath."".$llini;
$frontendB="\\\\".$serverB."".$llrootpath."".$sitename."".$llconfigpath."".$llini;
if ($lastserver>2){ $frontendC="\\\\".$serverC."".$llrootpath."".$sitename."".$llconfigpath."".$llini;
if ($lastserver>3){ $frontendD="\\\\".$serverD."".$llrootpath."".$sitename."".$llconfigpath."".$llini;
}}

print ("Comparing opentext.ini pwds for ".$sitename." on ".$serverA." to:\n".$serverB." ".$serverC." ".$serverD."\n");

open( FRONTENDADATA, "< $frontendA" ) || die ("Can't open $frontendA : $!");
while (<FRONTENDADATA>) {
	chop $_;
	if ($_ =~ /AdminCookie=.*/ ) {
		$serverAcookie=$_;
		#print ("\n".$_ );  # debug
		}
	if ($_ =~ /adminpwd=.*/ ) {
		$serverApwd=$_;
		#print ("\n".$_ );  # debug
		}
} 
close (FRONTENDADATA);
#print "\n".$frontendA."\n" ;

open( FRONTENDBDATA, "< $frontendB" ) || die ("Can't open $frontendA : $!");
while (<FRONTENDBDATA>) {
	chop;
	if ($_ =~ /AdminCookie=.*/ ) {
		$serverBcookie=$_;
		#print ("\n".$_ );  # debug
		}
	if ($_ =~ /adminpwd=.*/ ) {
		$serverBpwd=$_;
		#print ("\n".$_ );  # debug
		}
}
close (FRONTENDBDATA);
#print "\n".$frontendB."\n" ;

if ( $lastserver > 2 ) {
open( FRONTENDCDATA, "< $frontendC" ) || die ("Can't open $frontendA : $!");
while (<FRONTENDCDATA>) {
	chop;
	if ($_ =~ /AdminCookie=.*/ ) {
		$serverCcookie=$_;
		#print ("\n".$_ );  # debug
		}
	if ($_ =~ /adminpwd=.*/ ) {
		$serverCpwd=$_;
		#print ("\n".$_ );  # debug
		}
}
close (FRONTENDCDATA);
#print "\n".$frontendC."\n" ;
}

if ( $lastserver > 3 ) {
open( FRONTENDDDATA, "< $frontendD" ) || die ("Can't open $frontendA : $!");
while (<FRONTENDDDATA>) {
	chop;
	if ($_ =~ /AdminCookie=.*/ ) {
		$serverDcookie=$_;
		#print ("\n".$_ );  # debug
		}
	if ($_ =~ /adminpwd=.*/ ) {
		$serverDpwd=$_;
		#print ("\n".$_ );  # debug
		}
}
close (FRONTENDDDATA);
#print "\n".$frontendD."\n" ;
}

if ( $serverAcookie =~ $serverBcookie ) { 
	$match=1; 
	print "\n".$serverB.".....OK\n" ;
	} else { 
	print "\n".$serverB.".....INCORRECT" ;
	print ("\n".$frontendB." does not match Anchor server\n") ;
	}

if ($lastserver>2) { 
	if ( $serverAcookie =~ $serverCcookie ) { 
		$match=1; 
		print "\n".$serverC.".....OK\n" ;
		} else { 
		print "\n".$serverC.".....INCORRECT" ;
		print ("\n".$frontendC." does not match Anchor server\n") ;
		} 
	}

if ($lastserver>3) { 
	if ( $serverAcookie =~ $serverDcookie ) { 
		$match=1; 
		print "\n".$serverD.".....OK\n" ;
		} else { 
		print "\n".$serverD.".....INCORRECT" ;
		print ("\n".$frontendD." does not match Anchor server\n") ;
		} 
	}

exit 0 ;

