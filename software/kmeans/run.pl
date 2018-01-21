#!/usr/bin/perl
use File::Copy;
use Tie::File


#$num_args = $#ARGV + 1;
#$file_name=$ARGV[0];

#$inf0 = $file_name.".log";
#$tmp0= "tmp0.log";
$outc = "result.log";

#open in0, "<$inf0" or die "Can't read file!";
open out0, ">$outc" or die "Can't read file!";

#@lines= <in0>;
#close(in0);
#chomp(@lines);
#my $count_lines=@lines;


#my $init = 90;
my $init = 0;
#print out0 "Avg. Error\n";

for ($j=0;$j<11;$j=$j+1){
$tmp = "\#include \"panda_orig4x".$init.".h\"";
#$cmd2 = "raw".$init."_pixels.h";
system("sed -i '15s/.*/$tmp/' kmeans2.c");
system("gcc -lm -lrt kmeans2.c");
print $init;
system("./a.out");
#system("./a.out | tee -a $outc");
#$init = $init + 1;
$init = $init + 10;
}

close(out0);

