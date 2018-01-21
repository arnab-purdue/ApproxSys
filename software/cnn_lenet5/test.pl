#!/usr/bin/perl


use strict;
use warnings;

my @arr = (0 .. 255);

foreach my $v (@arr)
{
    my $vq = ($v/255)*2 - 1;
    my $vqe = int ($vq * 127);
    print "$v -- $vq -- $vqe\n";
}
