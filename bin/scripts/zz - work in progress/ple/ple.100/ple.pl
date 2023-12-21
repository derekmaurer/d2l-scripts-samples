#!c:\perl\bin\perl.exe
########


if ($#ARGV != 0 ) {
	print "usage: ple {url}\n";
	exit;
}

$myurl=$ARGV[0];

use LWP::UserAgent;
#require HTTP::Cookies;
use Archive::Zip;
use Win32API::GUID;

$user_agent = new LWP::UserAgent;
$user_agent->cookie_jar( {} );

$request = new HTTP::Request ('GET',$myurl);
	$response = $user_agent->request($request);
	$raw_data = $response->content;
	
$copyofrawdata=$raw_data;

@anotherlist=split (/"/, $raw_data);

open ( RSSFILE , "> rss");
open ( HTMLFILE , "> html");

$counttwo = 0;

print HTMLFILE (' <h1> Index of '.$myurl.'</h1></tr><tr>');

while ($anotherlist[$n]) {
	#print ($anotherlist[$count]);
	if ($anotherlist[$count] =~ /<A HREF=/i) {
	if (($anotherlist[$count+1] =~ /jpg/i) || ($anotherlist[$count+1] =~ /gif/i))  {
		if ($counttwo > 5 ) { 
			print HTMLFILE (' </tr><tr> ');
			$counttwo = 0; 
		} 
		$counttwo++;
		
	$ug = CreateGuid();   
   	$fullurl = $myurl.$anotherlist[$count+1] ;
   	
	print RSSFILE ("\n".'        <item>'."\n".'            <title>'.$fullurl.'</title>');
	print RSSFILE ("\n".'            <link>'.$fullurl.'</link>');
	print RSSFILE ("\n".'            <media:thumbnail url="'.$fullurl.'"/>');
	print RSSFILE ("\n".'            <media:content url="'.$fullurl.'"/>');
	print RSSFILE ("\n".'            <guid isPermaLink="false">'.$ug.'</guid>'."\n");
	print RSSFILE ("\n".'        </item>');
	print HTMLFILE ("\n".'		<td><a href="'.$fullurl.'"> ');
	print HTMLFILE ("\n".'		    <img src="'.$fullurl.'">');
	print HTMLFILE ("\n".'		    <span class="mbf-item">#gallery '.$ug.'</span>');
	print HTMLFILE ("\n".'		</a></td> ');

	}
	}
	$n++;
	$count++;
}

print HTMLFILE ("\n");

close( RSSFILE );
close( HTMLFILE );

system("del gallery.html  ");
system("type htmlhead >>gallery.html  ");
system("type html >>gallery.html  ");
system("type htmlfoot >>gallery.html  ");
system("del photos.rss ");
system("type rsshead >>photos.rss ");
system("type rss >>photos.rss ");
system("type rssfoot >>photos.rss ");
system("gallery.html");
