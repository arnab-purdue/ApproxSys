#!/usr/bin/perl
use File::Copy;
use Tie::File

#$num_args = $#ARGV + 1;
#$file_name=$ARGV[0];

$filename = "mt_nz4xqbin8";

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
$tf = "\#include \"$filename".$init.".h\"";
$tf2 = "fp = fopen(\"smooth_$filename".$init.".m\",\"w+\");";

print $init."\n";
system("sed -i '12s/.*/$tf/' smoothen.c"); 
system("sed -i '76s/.*/$tf2/' smoothen.c"); 
system("gcc -lm smoothen.c");
system("./a.out");

#$init = $init + 1;
$init = $init + 10;
}


