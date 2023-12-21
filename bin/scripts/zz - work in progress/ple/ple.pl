#!c:\perl\bin\perl.exe
#
# 2008/06/25 - derekmaurer@gmail.com
#
#  Simple perl script to build html and related rss file for PicLens
# image slidehow application (www.piclens.com) from URL with images.
#
# Usage:  ple.pl URL
#
# History
#
# 0.1 
# - built PicLens enabled HTML and RSS file from URL with images such as an 'index of' page.
# - able to save images to a .\cache folder when $usecache is enabled
# - only checks for gif and jpg images right now
# - windows only system() command currently called
#
# Future
#
# - inbed HTML and RSS header and footer code inline with ple.pl
# - add support for flv enabled slideshow
# - split large slideshows into albums for Piclens
# - when usecache enabled option to create and use thumbnails (w/ ImageMagik)
# - convert non jpg/gif images to jpg for slideshow (w/ ImageMagik)
# - add support to read list of URL from imput file and build multiple Piclens slideshow in batch
#
########

#set to 1 to enable cache folder settings (usecache must be enable if thumbnails are enabled)
$usecache = 1 ;
$thumbnails = 1 ;
@thumbnaillist = ();

#check if URL is supplied
if ($#ARGV != 0 ) {
	print "usage: ple {url}\n";
	exit;
}

#set variable from argument supplied
$myurl=$ARGV[0];

#enable needed perl packages
use LWP::UserAgent;
use Archive::Zip;
use Win32API::GUID;

#subroutine to URL decode filenames
sub URLDecode {
my $theURL = $_[0];
$theURL =~ tr/+/ /;
$theURL =~ s/%([a-fA-F0-9]{2,2})/chr(hex($1))/eg;
$theURL =~ s/<!-(.|\n)*->//g;
return $theURL;
}

#request data from URL suppiled
$user_agent = new LWP::UserAgent;
$user_agent->cookie_jar( {} );

$request = new HTTP::Request ('GET',$myurl);
	$response = $user_agent->request($request);
	$raw_data = $response->content;

#put the recieved page into an array split at the " in the data
@anotherlist=split (/"/, $raw_data);

#open the two output files needed to build HTML and RSS
open ( RSSFILE , "> rss");
open ( HTMLFILE , "> html");

#set a counter to manage location of interesting array elements
$counttwo = 0;

#start writing HTML body
print HTMLFILE (' <h1> Index of '.$myurl.'</h1></tr><tr>');

###process data for image information and write HTML and RSS body
while ($anotherlist[$n]) {
	#print ($anotherlist[$count]);
	if ($anotherlist[$count] =~ /<A HREF=/i) {						# look for 'A HREF' 		
	if (($anotherlist[$count+1] =~ /jpg/i) || ($anotherlist[$count+1] =~ /gif/i))  {	# next line is the image filename, check that image is jpg or gif
		if ($counttwo > 5 ) { 								# start new row if more than five images found
			print HTMLFILE (' </tr><tr> ');
			$counttwo = 0; 
		} 
		$counttwo++;
		
	$ug = CreateGuid();   									# generate guid for PicLens to match RSS and HTML data
   	$fullurl = $myurl.$anotherlist[$count+1] ;						# set fullurl variable to the complete URL of imagefile
   	$thumburl = $myurl.$anotherlist[$count+1] ;						# set thunburl variable to the complete URL of imagefile in case thumbnails not enabled
   	
   if ($usecache = 1) {										# if usecache is enabled, start downloading images and overide fullurl location
	
	$cleanfilename = URLDecode($anotherlist[$count+1]);					# decode URL encode filenamesbefore saving to disk
	
	print ("Retrieving : ".$fullurl." \> cache\\".$cleanfilename."\n");   			# display processing information as this could take some time
   	
   	open (IMAGECACHE, ">cache\\".$cleanfilename);						# open new imagefile in .\cache folder for writing
			$imagerequest= new HTTP::Request ('GET',$fullurl);			# get image from fullurl and process
			$imageresponse=$user_agent->request($imagerequest);
			$raw_datatwo=$imageresponse->content;
			binmode IMAGECACHE;							# set imagefile to binary
			print IMAGECACHE ($raw_datatwo);					# write imagefile from data retrieved
	close (IMAGECACHE);
   	$fullurl = 'cache\\'.$cleanfilename ;							# set fullurl to locally cache filename
   	$thumburl = 'cache\\'.$cleanfilename ;							# set thumburlurl to locally cache filename in case thumbnails are not enabled
   }
   
   if ($thumbnails = 1) {
   	$thumburl = 'cache\\thm_'.$cleanfilename ;						# set thumburlurl to locally cache thumbnail filename 
   	push(@thumbnaillist, '"'.$fullurl.'" "'.$thumburl.'"');
      }
   	
	print RSSFILE ("\n".'        <item>'."\n".'            <title>'.$fullurl.'</title>');	# build HTML and RSS body with image location
	print RSSFILE ("\n".'            <link>'.$fullurl.'</link>');
	print RSSFILE ("\n".'            <media:thumbnail url="'.$thumburl.'"/>');
	print RSSFILE ("\n".'            <media:content url="'.$fullurl.'"/>');
	print RSSFILE ("\n".'            <guid isPermaLink="false">'.$ug.'</guid>'."\n");
	print RSSFILE ("\n".'        </item>');
	print HTMLFILE ("\n".'		<td><a href="'.$fullurl.'"> ');
	print HTMLFILE ("\n".'		    <img src="'.$thumburl.'">');
	print HTMLFILE ("\n".'		    <span class="mbf-item">#gallery '.$ug.'</span>');
	print HTMLFILE ("\n".'		</a></td> ');

	}
	}
	$n++;
	$count++;
}

print HTMLFILE ("\n");

# close HTML and RSS files
close( RSSFILE );
close( HTMLFILE );

#create thumbnails
if ($thumbnails = 1) {
	$countthree=0;
	while ($thumbnaillist[$countthree]) {
		print ('convert -thumbnail 200x200 '.$thumbnaillist[$countthree]);
		print ("\n");
		system ('convert -thumbnail 200x200 '.$thumbnaillist[$countthree]);
		$countthree++;
	}
	
}

#process htmlhead + html + htmlfoot into gallery.html file for viewing
system("del gallery.html  ");
system("type htmlhead >>gallery.html  ");
system("type html >>gallery.html  ");
system("type htmlfoot >>gallery.html  ");

#process rsshead + rss + rssfoot into photos.rss for Piclens to use to build slideshow
system("del photos.rss ");
system("type rsshead >>photos.rss ");
system("type rss >>photos.rss ");
system("type rssfoot >>photos.rss ");

#launch gallery.html with associated browser
system("gallery.html");


 __DATA__ 
  
 ##htmlfoot
 		</table>
 		<hr size="1" style="color:#ccc">
 		<div>
 			<a href="javascript:PicLensLite.start();">Start Slide Show <img src="http://lite.piclens.com/images/PicLensButton.png" alt="PicLens" width="16" height="12" border="0" align="absmiddle"></a>
 		</div>
 	</div>
 </body>
</html>

##htmlhead
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>files</title>
	<link id="gallery" rel="alternate" href="photos.rss" type="application/rss+xml">
	<script type="text/javascript" src="http://lite.piclens.com/current/piclens.js"> </script>
	<style type="text/css">
        a {
            color: #00f;
        }
		#pl_main {
			width: 700px;
			margin: 20px auto;
			font-family: Arial;
			font-size: 14px;
			line-height: 18px;
			color: #333;
		}
		table.gallery {
			padding: 5px;
			width: 100%;
		}
		table.gallery td {
			text-align: center;
		}
		table.gallery img {
			padding: 5px;
			margin: 2px;
			border: 1px solid #ccc;
			max-width: 120px;
			max-height: 120px;
		}
		.mbf-item { display: none; }
	</style>
</head>
<body>
	<div id="main">
		<h1>files</h1>
		<hr size="1" style="color:#ccc">
		<table class="gallery">
		<tr>
		
##rssfoot
    </channel>
</rss>

##rsshead
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<rss xmlns:media="http://search.yahoo.com/mrss" version="2.0">
    <channel>    