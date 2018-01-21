#!/usr/bin/perl
use File::Copy;
use Tie::File;
use Data::Dumper qw(Dumper);

$outf1 = "out.log";

open outn1, ">$outf1" or die "Can't read file!";

my $val = 90;
my $range = 11;

for($j=0;$j<$range;$j++){
$cmd = "input".$val.".h";
system("sed -i '/\#include \"input/c\\#include \"$cmd\"' knn.c");
system("gcc -lm knn.c");
system("./a.out | tee -a out.log");
$val = $val+1;
}

#my ($tp3,$tp4) = split /\:/,$tp2[$j]; 
