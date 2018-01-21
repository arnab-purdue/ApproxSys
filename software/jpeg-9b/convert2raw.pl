#!/usr/bin/perl
use File::Copy;
use Tie::File;
use Data::Dumper qw(Dumper);

$filename = "mt_nz4xqbin8";
#$filename1 = "solvay4xqbin6";
#$filename2 = "dfb4xqbin6";
#$filename3 = "nasa4xqbin6";

my $val = 0;
my $range = 11;

for($j=0;$j<$range;$j++){

$outit = $filename.$val.".jpg";
#$outit1 = $filename1.$val.".jpg";
#$outit2 = $filename2.$val.".jpg";
#$outit3 = $filename3.$val.".jpg";

$pgmout = $filename.$val.".pgm";
#$pgmout1 = $filename1.$val.".pgm";
#$pgmout2 = $filename2.$val.".pgm";
#$pgmout3 = $filename3.$val.".pgm";

system("djpeg -grayscale -outfile $pgmout $outit");
#system("djpeg -grayscale -outfile $pgmout1 $outit1");
#system("djpeg -grayscale -outfile $pgmout2 $outit2");
#system("djpeg -grayscale -outfile $pgmout3 $outit3");
$val = $val+10;
}

#my ($tp3,$tp4) = split /\:/,$tp2[$j]; 
