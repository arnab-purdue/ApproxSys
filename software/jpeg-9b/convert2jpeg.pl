#!/usr/bin/perl
use File::Copy;
use Tie::File;
use Data::Dumper qw(Dumper);


$filename = "mt_nz4xqbin8";
#$filename1 = "solvay4xqbin6";
#$filename2 = "dfb4xqbin6";
#$filename3 = "nasa4xqbin6";

$pgmfn = $filename.".pgm";
#$pgmfn1 = $filename1.".pgm";
#$pgmfn2 = $filename2.".pgm";
#$pgmfn3 = $filename3.".pgm";

my $val = 0;
my $range = 11;

for($j=0;$j<$range;$j++){

$outit = $filename.$val.".jpg";
#$outit1 = $filename1.$val.".jpg";
#$outit2 = $filename2.$val.".jpg";
#$outit3 = $filename3.$val.".jpg";

system("cjpeg -quality $val -grayscale -outfile $outit $pgmfn");
#system("cjpeg -quality $val -grayscale -outfile $outit1 $pgmfn1");
#system("cjpeg -quality $val -grayscale -outfile $outit2 $pgmfn2");
#system("cjpeg -quality $val -grayscale -outfile $outit3 $pgmfn3");
$val = $val+10;
}

#my ($tp3,$tp4) = split /\:/,$tp2[$j]; 
