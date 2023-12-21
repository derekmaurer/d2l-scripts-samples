#!e:\perl\perl.exe
#----------------------------------------------------
# unix2dos <file name>
#
my $dos        = "\015\012";
my $unix       = "\n";
$fn = $ARGV[0];
open( IN, $fn)  || die ("\n can not read $fn \n");
open( OUT, ">tempfile") || die ("\n can not write $fn \n");
$flag = 0;
$lineNo = 0;

while( <IN>){
   $lineNo++;
   $line = $_;
   $line =~ s/$unix/$dos/g;
   print OUT "$line";
}
close(IN);
close(OUT);
rename (tempfile, $fn) || die "couldn't rename tempfile to $fn.\n";
