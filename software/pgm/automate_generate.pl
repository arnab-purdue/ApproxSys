#!/usr/bin/perl
use File::Copy;
use Tie::File


#$num_args = $#ARGV + 1;
#$file_name=$ARGV[0];

#$inf0 = $file_name.".log";
#$tmp0= "tmp0.log";
$filename = "mt_nz4xqbin8";
#open in0, "<$inf0" or die "Can't read file!";

#@lines= <in0>;
#close(in0);
#chomp(@lines);
#my $count_lines=@lines;


#my $init = 90;
my $init = 0;
#print out0 "Avg. Error\n";

for ($j=0;$j<11;$j=$j+1){
$cmd = $filename.$init.".pgm";
$tmp = $filename.$init.".h";
#$cmd2 = "raw".$init."_pixels.h";
system("./pgmDemo $cmd ");
system("mv input.h $tmp");
#$init = $init + 1;
$init = $init + 10;
}

close(out0);

