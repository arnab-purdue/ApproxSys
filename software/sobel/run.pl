#!/usr/bin/perl
use File::Copy;
use Tie::File

#$num_args = $#ARGV + 1;
#$file_name=$ARGV[0];

$filename = "eagle4xqbin2";

#$inf0 = $file_name.".log";
#$tmp0= "tmp0.log";

#open in0, "<$inf0" or die "Can't read file!";

#@lines= <in0>;
#close(in0);
#chomp(@lines);
#my $count_lines=@lines;

#my $init = 90;
my $init = 0;

for ($j=0;$j<11;$j=$j+1){
$tmp = "\#include \"$filename".$init.".h\"";
#$cmd2 = "raw".$init."_pixels.h";
system("sed -i '12s/.*/$tmp/' sobelrnr.c"); 
system("gcc -lm -lrt sobelrnr.c");
print $init."\n";
system("./a.out");
#$init = $init + 1;
$init = $init + 10;
}

close(out0);

