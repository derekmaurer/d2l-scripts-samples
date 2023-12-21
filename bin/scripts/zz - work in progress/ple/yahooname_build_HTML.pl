#!e:\perl\bin\perl.exe

########
# yahooname_build_HTML.pl	v0.91 - 1/12/2005
# derekmaurer@rogers.com
# This takes a list of yahoo names and builds a 'who is online' webpage.
# 
# Description:
# Link for profile page, message user and profile photo will eventually be included
# in a HTML table.
#
# Usage:
# Add to the bottom on the yahoonameslist.txt and it will automatically be sorted
# and remove duplicate entries; there no need to manually check for duplicates.
# HTML will be build as yahoonamesonline.html, view with a browser.
#
# Future Plans:
# Eventual goal will be to build a public webpage that can be added to by 
# the public and deleted from the list automatically when names become 'stale'.
# - need to build simple DB to store results when building web interface
# - 'build' script run on a schedule at server, details at runtime stored in DB
# - multiply pages construct HTML from DB info
# - online builds from DB/yahoo online status (depaends on time for yahoo)
# - filter based on profile info/web user added info
# - allow comments to be added by webuser (display last 5-10 definable)
#
# Distant Future Plans:
# Other ideas include a simple Yahoo profile crawler to a names automatically,
# filter bot automatically, a rating system, user comments, 'exclusion list' 
# for people that don't want their profile on the list, a top 10/best of list,
# possibly even try to generate some revenue from ads, etc. before this whole
# project becomes 'flooded' with users. (Eventually when open to the public
# the list would get abused to a point either Yahoo will shut it down or
# names will always be flooded. Also may add a 'featured' area with a mirror
# of the webcam for all to view (multicast, 30+ concurrent users, low bandwidth 
# overhead)...
#
#
# History
#
#	Monday, January 17, 2005
#	- build first web based version for POC (remove file output and status messages)
#	- issues with auth (mostly an IIS issue)
#	- very slow outputing list this way, need to consider DB to store info
#	  and static HTML to pull from DB, script will be run on schedule rather than user
#	  invoked
#
# 0.91	Wednesday, January 12, 2005
#	- oooh, a new version _number_, justified by adding some completely new ideas
#	- added 'export online to new list' feature for other software to use (webcam software)
#	- cleaned up status messages some more
#
# 0.9h  Wednesday, January 12, 2005
#	- adult profile tweaks (fixing it completely actually)
#	  I broke the login URL when I wrapped everything in a IF statement
#	- fixed some international profiles will fix others as I come across them
#	- tag adult profiles
#	- added some extra error checking to keep output nice if there are exceptions
#
# 0.9g	Monday, January 10, 2005
#	- adult profile now supported (learned how perl handles SSL/cookies)
#	  now we get the profile, check to see if it an 'adult profile', if it is
#	  authenticates via Yahoo's SSL login and saves cookie when authenticating
#	  then we re-request the same profile with credentials saved in the cookie 
#	(yay, I'm learning perl stuff... grumble grumble)
#	
# 0.9f	Sunday, January 09, 2005
#	- after shelving this code for a long time started mucking with it again
#	- added flag to allow building a list with both online and offline users
#	- added 'basic' profile data as listed by yahoo into the table
#	  this can be turned on or off
#	- changed output of script to display work being done for each name
#
# 0.9e  Tuesday, August 5, 2003
#	- added URL for yahoo login
#	- enable adult profiles (otherwise no profile photo would display)
#
# 0.9d  Monday, July 21, 2003
# 	- checks the online status and only splits out online names
#	- crc code added for the above and to be used elsewhere in the 
#	  next release (checking for profile updates maybe)
#
# 0.9c  Friday, July 11, 2003
#	- now caches the current profile image, if avaialble, to disk
#	  this is used in place of dynamic image URLs
#	- check for .jpg or .gif format when saving images
#	- resize images to a 'standard' size
#	- changed list format (for the better I hope)
#	- on Yahoo 'if you can't play fair, cheat' ;)
#
# 0.9b	Thursday, July 10, 2003
#	- fixed the photo url problem by requesting it on the fly, this
#	  is NOT a permanent fix as the links WILL eventually change
#	- links seems to change after 5-6 unique requests (tricky tricky) :(
#
# 0.2	Tuesday, July 8, 2003
#	- added working profile photo url through an external script
#	- I 'underestimate Yahoo's trickyness'; photo urls are dynamic
#
# 0.1	Tuesday, July 8, 2003
#	- first attempts at adding the current profile photo, 
#	- Yahoo is being tricky, they are smarter than I thought >:(
#
# 0.01a - first internal build
#	- sorts a list of names, removes doubles and splits out a HTML list
#	- includes online status, profile link
#
# Todo:
#	- sort list by who is online to the top
#	- checked cached photos when rebuilding list, only download when updated
#	- link on page to update list
#
#


system("sort yahoonameslist.txt | uniq > clean_yahoonames.tmp");
system("copy clean_yahoonames.tmp yahoonameslist.txt");
system("del clean_yahoonames.tmp");

use LWP::UserAgent;
require HTTP::Cookies;
use Archive::Zip;

$user_agent = new LWP::UserAgent;
$user_agent->cookie_jar( {} );

$yahooauthname = "cougar99plus" ; # fill in your own yahoo login
$yahooauthpasswd = "krakin" ; # fill in your own password
$loginurl = "https://login.yahoo.com/config/login?&login=".$yahooauthname."&passwd=".$yahooauthpasswd ; 
$nophotourl = "http://us.i1.yimg.com/us.yimg.com/i/ppl/no_photo.gif"; #url used for profiles without a photo
$retries = 3;	#number of profile GET retries before moving to the name profile
$sleeptime = 1;	#seconds to wait between profiles gets
$onlinecrc = 3872161340; #crc of the yahoo is_online status
$all = 0; # set to 1 for both online and offline names in the yahoonameslist will be processed
$profile = 1; # display yahoo profile 0=off or 1=on
$onlineoutput = 0 ; # create online names list 'yahoonamesonline.txt'

open(NAMESTOO,"<yahoonameslist.txt");
open(HTMLNAMESOUT,"+>yahoonamesonline.html");
if ($onlineoutput > 0) { open(NAMESOUT,"+>yahoonamesonline.txt"); }

while (<NAMESTOO>){

	$photo=0;
	$countthree=0;
	$name=$_;
	chop($name);

	$request = new HTTP::Request ('GET','http://opi.yahoo.com/online?u='.$name.'&m=g&t=2');
	$response = $user_agent->request($request);
	$raw_data = $response->content;
	
	$crc = Archive::Zip::computeCRC32($raw_data, 32);
	
	if (($crc eq $onlinecrc) || ($all > 0)){ 
	
	$request = new HTTP::Request ('GET','http://profiles.yahoo.com/'.$name);
	$response = $user_agent->request($request);
	$raw_data=$response->content; 
	# print ($raw_data);

	if ($raw_data =~ /.*Profile contains possible adult content.*/ ) {
		$user_agent->cookie_jar( {} );
		$request = new HTTP::Request ('GET', $loginurl.'&.src=ytc&.done=http%3a//edit.profiles.yahoo.com/config/prof_wall%3f.idname='.$name.'%26.warned=1' ); 
		$response = $user_agent->request($request);
		$raw_data=$response->content; 
		# print ($raw_data);	
        	$request = new HTTP::Request ('GET','http://edit.profiles.yahoo.com/config/prof_wall?.idname='.$name.'&.warned=1');
		$response = $user_agent->request($request);
		$raw_data=$response->content; 
		# print ($raw_data);	
		$adultprofile=1
		}
	
	$raw_datatwo=$raw_data;
	print ($request." ".$name."\n");
		
	@anotherlist=split (/"/, $raw_data);
	@anotherlisttwo=split (/\n/, $raw_datatwo);	
	
	while ($counttwo < 400) {
			
			# print $anotherlist[$counttwo];
			
			while ($countfive < 500) {
				if ($profile > 0 ) {
								
					if ($anotherlisttwo[$countfour] =~ /Yahoo! ID:|Yahoo!-ID|Compte Yahoo/) {
						# print ($anotherlisttwo[$countfour]);
						print ("Adding Profile info..."); 
						$hasprofile=1;
						$firstcount=$countfour;
						while ($countfive < 500 ) {
							# print ($anotherlisttwo[$countfour]);
							$countfour++;
							if ($anotherlisttwo[$countfour] =~ /<\/table>/ ) {
								$countfive=501;
							}
							$countfive++;
						}
					}
					
					if ($anotherlisttwo[$countfour] =~ /.*Sorry, but the profile you are looking for is not currently available.*/ ) {
						print ("No Profile, or profile unavailable...");
						$hasprofile=0;
					}
					
					if ($anotherlisttwo[$countfour] =~ /.*Profile contains possible adult content.*/ ) {					
						print ("Adult Profile, unsupported...");
						$hasprofile=0;
					}
					$countfour++;
				}
				$countfive++;
			}
			
			if ($anotherlist[$counttwo] =~ /http.*\/users.*/ ) {
				print ("Adding Profile Photo...");
				# print ("\n".$anotherlist[$counttwo]."\n\n\n");
				$currentphotourl=$anotherlist[$counttwo];
				
				if ($currentphotourl =~ /.*\.gif\?.*/){ $ext=".gif"; } else {$ext=".jpg";}
				
				open (IMAGECACHE, ">cache\\".$name.$ext);
					$imagerequest= new HTTP::Request ('GET',$currentphotourl);
					$imageresponse=$user_agent->request($imagerequest);
					$raw_datatwo=$imageresponse->content;
					binmode IMAGECACHE;
					print IMAGECACHE ($raw_datatwo);
				close (IMAGECACHE);
				
				$profileurl='cache\\'.$name.$ext;
				$photo = 1;
				last;
			} 
			if ($anotherlist[$counttwo] =~ /was not found on this server/ and $countthree < $retries) {
				print ("...retrying profile GET\n");
				
				$request = new HTTP::Request ('GET','http://profiles.yahoo.com/'.$name);
				$response = $user_agent->request($request);
				$raw_data=$response->content;
				
				$counttwo=0;
				$countthree++;
				}			
		$counttwo++;
		}
	$counttwo=0;
	if ($photo < 1){
		print ("No Profile Photo...");
		$profileurl=$nophotourl;
		}
	sleep($sleeptime);
	
	$counter++;
	print HTMLNAMESOUT ("<hr><table> <tr><table cellspacing=0 cellpadding=2 border=0 width='100%'><tr><td valign=top><tr> <td width='10%'><p align='right'><h2>".$counter.".</h2></td><td colspan=2><table cellspacing=0 cellpadding=2 border=0><tr><td align=right>");
	
	if ($hasprofile > 0) {
		while ($firstcount < ($countfour - 1 ) ) {
			print HTMLNAMESOUT ($anotherlisttwo[$firstcount]);
			$firstcount++;
		}
	} else { print HTMLNAMESOUT ("<font face=arial size='-1'>      Error:</font></td><td><font face=arial size='-1' color='#660000'><b>No Profile found     </b></font></td></tr>"); }
	
	if ($adultprofile > 0) {
		print HTMLNAMESOUT ("<font face=arial size='1' color='#660000'>Adult Profile</font></td><td><b></b></font></td></tr>");
		$adultprofile=0;
		}
	
	print HTMLNAMESOUT ("</table><td width='70%'><p align='right'>".$name."<br><a href='http://edit.yahoo.com/config/send_webmesg?.target=".$name."&.src=pg'><img border=0 src='http://opi.yahoo.com/online?u=".$name."&m=g&t=2'></a><br><a href='http://profiles.yahoo.com/".$name."'>View Profile</a><br></td> <td width='60%'><p align='left'><a href='http://profiles.yahoo.com/".$name."'><img width='250' src='".$profileurl."' alt='".$name."'></a></tr></table>");
		
	if (($onlineoutput > 0) && ($crc eq $onlinecrc)) {
		print NAMESOUT ( $name."\n" );
		print ("Added to yahoonamesonline.txt...") ;
		}
	$firstcount=0;
	$countfour=0;
	$countfive=0;
	
	print ("\n\n") ;
	
	}
	}

close (HTMLNAMESOUT);
close (NAMESTOO);
if ($onlineoutput > 0) { close (NAMESOUT); }