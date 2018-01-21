#!/usr/bin/perl
use File::Copy;
use Tie::File

#$num_args = $#ARGV + 1;
#$file_name=$ARGV[0];

$filename = "mnistqbin8";

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
$tf2 = "fp = fopen(\"test_$filename".$init.".h\",\"w+\");";

system("sed -i '4s/.*/$tf/' convert_mnist.c"); 
system("sed -i '13s/.*/$tf2/' convert_mnist.c"); 
system("gcc -lm convert_mnist.c");
system("./a.out");

$tmp = "\#include \"test_$filename".$init.".h\"";
#$cmd2 = "raw".$init."_pixels.h";
system("sed -i '11s/.*/$tmp/' cnn_fp_app_sys.cpp"); 
system("g++ -lm cnn_fp_app_sys.cpp -lrt");
print $init."\n";
system("./a.out");
#$init = $init + 1;
$init = $init + 10;
}


