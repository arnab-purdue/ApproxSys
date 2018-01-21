#!/usr/bin/perl


use strict;
use warnings;
use List::Util qw(max min) ;
my $pf = "params_tanh.h";
my $of = "params_tanh_q.h";

my @c1;
my @s2;
my @c3;
my @s4;
my @c5;
my @f6;

open(PF,$pf) or die " DIED - Cannot open parameter File $pf\n";
while(my $line = <PF>)
{
     $line =~ /\{(.*)\}/;
     my $vals = $1;
     
     if ($line =~ /C1/)
     {
         @c1 = split(",",$vals);
     }
     elsif ($line =~ /S2/)
     {
         @s2 = split(",",$vals);
     }
     elsif ($line =~ /C3/)
     {
         @c3 = split(",",$vals);
     }
     elsif ($line =~ /S4/)
     {
         @s4 = split(",",$vals);
     }
     elsif ($line =~ /C5/)
     {
         @c5 = split(",",$vals);
     }
     elsif ($line =~ /F6/)
     {
         @f6 = split(",",$vals);
     }
}
close(PF);


my $pmax = max(@c1,@s2,@c3,@s4,@c5,@f6);
my $pmin = min(@c1,@s2,@c3,@s4,@c5,@f6);
print "MAX: $pmax,    MIN: $pmin\n"; 

my $scale_max  = 1;
my $scale_min  = -1;
my $no_levels  = 256;
my $amp = 127;
my $lev_range  = ($scale_max - $scale_min) / $no_levels;
open(OF,">$of") or die "DIED - Cannot open output file to write \n";
{
    print OF "float wbC1[156] = {";
    for (my $c = 0; $c < @c1 ; $c++)
    {
        my $v = $c1[$c];
        my $qv;
        if($v < $scale_max && $v > $scale_min)
        {
            my $op_lev = int(($v-$scale_min)/$lev_range);
            my $qvf = $op_lev * $lev_range + $scale_min;
            my $qvc = ($op_lev+1) * $lev_range + $scale_min;
            $qv = (($v-$qvf) < ($qvc-$v)) ? $qvf : $qvc;
            $qv = int($qv * $amp);
        }
        elsif($v <= $scale_min)
        {
            $qv = $scale_min;
            $qv = int($qv * $amp);
        }
        else
        {
            $qv = $no_levels * $lev_range + $scale_min;
            $qv = int($qv * $amp);
        }
        if($c == $#c1)
        {
            print OF " $qv";
        }
        else
        {
            print OF " $qv,";
        }
    }
    print OF "};\n";
    
    print OF "float wbS2[12] = {";
    for (my $c = 0; $c < @s2 ; $c++)
    {
        my $v = $s2[$c];
        my $qv;
        if($v < $scale_max && $v > $scale_min)
        {
            my $op_lev = int(($v-$scale_min)/$lev_range);
            my $qvf = $op_lev * $lev_range + $scale_min;
            my $qvc = ($op_lev+1) * $lev_range + $scale_min;
            $qv = (($v-$qvf) < ($qvc-$v)) ? $qvf : $qvc;
            $qv = int($qv * $amp);
        }
        elsif($v <= $scale_min)
        {
            $qv = $scale_min;
            $qv = int($qv * $amp);
        }
        else
        {
            $qv = $no_levels * $lev_range + $scale_min;
            $qv = int($qv * $amp);
        }
        if($c == $#s2)
        {
            print OF " $qv";
        }
        else
        {
            print OF " $qv,";
        }
    }
    print OF "};\n";
    
    print OF "float wbC3[2416] = {";
    for (my $c = 0; $c < @c3 ; $c++)
    {
        my $v = $c3[$c];
        my $qv;
        if($v < $scale_max && $v > $scale_min)
        {
            my $op_lev = int(($v-$scale_min)/$lev_range);
            my $qvf = $op_lev * $lev_range + $scale_min;
            my $qvc = ($op_lev+1) * $lev_range + $scale_min;
            $qv = (($v-$qvf) < ($qvc-$v)) ? $qvf : $qvc;
            $qv = int($qv * $amp);
        }
        elsif($v <= $scale_min)
        {
            $qv = $scale_min;
            $qv = int($qv * $amp);
        }
        else
        {
            $qv = $no_levels * $lev_range + $scale_min;
            $qv = int($qv * $amp);
        }
        if($c == $#c3)
        {
            print OF " $qv";
        }
        else
        {
            print OF " $qv,";
        }
    }
    print OF "};\n";
    
    print OF "float wbS4[32] = {";
    for (my $c = 0; $c < @s4 ; $c++)
    {
        my $v = $s4[$c];
        my $qv;
        if($v < $scale_max && $v > $scale_min)
        {
            my $op_lev = int(($v-$scale_min)/$lev_range);
            my $qvf = $op_lev * $lev_range + $scale_min;
            my $qvc = ($op_lev+1) * $lev_range + $scale_min;
            $qv = (($v-$qvf) < ($qvc-$v)) ? $qvf : $qvc;
            $qv = int($qv * $amp);
        }
        elsif($v <= $scale_min)
        {
            $qv = $scale_min;
            $qv = int($qv * $amp);
        }
        else
        {
            $qv = $no_levels * $lev_range + $scale_min;
            $qv = int($qv * $amp);
        }
        if($c == $#s4)
        {
            print OF " $qv";
        }
        else
        {
            print OF " $qv,";
        }
    }
    print OF "};\n";
    
    print OF "float wbC5[48120] = {";
    for (my $c = 0; $c < @c5 ; $c++)
    {
        my $v = $c5[$c];
        my $qv;
        if($v < $scale_max && $v > $scale_min)
        {
            my $op_lev = int(($v-$scale_min)/$lev_range);
            my $qvf = $op_lev * $lev_range + $scale_min;
            my $qvc = ($op_lev+1) * $lev_range + $scale_min;
            $qv = (($v-$qvf) < ($qvc-$v)) ? $qvf : $qvc;
            $qv = int($qv * $amp);
        }
        elsif($v <= $scale_min)
        {
            $qv = $scale_min;
            $qv = int($qv * $amp);
        }
        else
        {
            $qv = $no_levels * $lev_range + $scale_min;
            $qv = int($qv * $amp);
        }
        if($c == $#c5)
        {
            print OF " $qv";
        }
        else
        {
            print OF " $qv,";
        }
    }
    print OF "};\n";
    
    print OF "float wbF6[1210] = {";
    for (my $c = 0; $c < @f6 ; $c++)
    {
        my $v = $f6[$c];
        my $qv;
        if($v < $scale_max && $v > $scale_min)
        {
            my $op_lev = int(($v-$scale_min)/$lev_range);
            my $qvf = $op_lev * $lev_range + $scale_min;
            my $qvc = ($op_lev+1) * $lev_range + $scale_min;
            $qv = (($v-$qvf) < ($qvc-$v)) ? $qvf : $qvc;
            $qv = int($qv * $amp);
        }
        elsif($v <= $scale_min)
        {
            $qv = $scale_min;
            $qv = int($qv * $amp);
        }
        else
        {
            $qv = $no_levels * $lev_range + $scale_min;
            $qv = int($qv * $amp);
        }
        if($c == $#f6)
        {
            print OF " $qv";
        }
        else
        {
            print OF " $qv,";
        }
    }
    print OF "};\n";
}






