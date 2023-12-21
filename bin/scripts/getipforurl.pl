#perl

#open (OUTFILE, 'urls_with_ips.txt');

open (URLFILE, 'urls.txt') || die("Could not open file!");

 while (<URLFILE>) {
 	chop($_);
 	print "-----------------------------\nurls.txt:$_\n";
 	my $output = readpipe("nslookup ".$_." 8.8.8.8 || awk '/Address/&&!/#/{print $2}'");
 	print "$output\n";
 }
 close (MYFILE); 
 
#####
# manually adjusted url/ip into collumns with textpad
#
#  grep "urls.txt\|Address" output.txt | grep -v "8.8.8.8"  > newlist
#
#  sed -e "s/Address:/\t\t\t/g" newlist | sed -e "s/urls.txt://g" > url-with-ip
#
#  grep "^...........*$" url-with-ip > new-url-with-ip
#
#
#