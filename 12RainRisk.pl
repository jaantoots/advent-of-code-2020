#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $dir = 0; # index from ENWS
my @pos = (0,0);
while (<>) {
    chomp;
    $pos[0] += $1 if /E(\d+)/;
    $pos[0] -= $1 if /W(\d+)/;
    $pos[1] += $1 if /N(\d+)/;
    $pos[1] -= $1 if /S(\d+)/;
    $dir -= $1/90 if /R(\d+)/;
    $dir += $1/90 if /L(\d+)/;
    $dir %= 4;
    $pos[$dir%2] += (-1)**int($dir/2)*$1 if /F(\d+)/;
}

say abs($pos[0]) + abs($pos[1]);
