#!/usr/bin/perl
use File::Copy;
use Tie::File

#$num_args = $#ARGV + 1;
#$file_name=$ARGV[0];

#$filename = "eagle4xqbin2";
$filename1 = "solvay4xqbin6";
$filename2 = "dfb4xqbin6";
$filename3 = "nasa4xqbin6";

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
#$cmd2 = "raw".$init."_pixels.h";
$fn1 = $filename1.$init.".pgm"; 
$fn2 = $filename2.$init.".pgm"; 
$fn3 = $filename3.$init.".pgm"; 
$fno1 = $filename1.$init."_output.pgm"; 
$fno2 = $filename2.$init."_output.pgm"; 
$fno3 = $filename3.$init."_output.pgm"; 
system("echo \" \""); 
system("echo \"$filename1\""); 
system("cp -r  $fn1 Face.pgm");
system("make clean");
system("make all");
system("make run");
system("cp -r Output.pgm $fno1");
system("echo \" \""); 
system("echo \"$filename2\""); 
system("cp -r  $fn2 Face.pgm");
system("make clean");
system("make all");
system("make run");
system("cp -r Output.pgm $fno2");
system("echo \" \""); 
system("echo \"$filename3\""); 
system("cp -r  $fn3 Face.pgm");
system("make clean");
system("make all");
system("make run");
system("cp -r Output.pgm $fno3");
$init = $init + 10;
}

close(out0);

