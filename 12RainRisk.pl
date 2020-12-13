#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $dir = 0; # index from ENWS
my @pos = (0,0);
my @way = (10,1);
my @wpos = (0,0);
while (<>) {
    chomp;
    # Part One
    $pos[0] += $1 if /E(\d+)/;
    $pos[0] -= $1 if /W(\d+)/;
    $pos[1] += $1 if /N(\d+)/;
    $pos[1] -= $1 if /S(\d+)/;
    $dir -= $1/90 if /R(\d+)/;
    $dir += $1/90 if /L(\d+)/;
    $dir %= 4;
    $pos[$dir%2] += (-1)**int($dir/2)*$1 if /F(\d+)/;
    # Part Two
    $way[0] += $1 if /E(\d+)/;
    $way[0] -= $1 if /W(\d+)/;
    $way[1] += $1 if /N(\d+)/;
    $way[1] -= $1 if /S(\d+)/;
    my $rot = 0;
    $rot -= $1/90 if /R(\d+)/;
    $rot += $1/90 if /L(\d+)/;
    $rot %= 4;
    while ($rot > 0) {
        @way = (-$way[1],$way[0]);
        $rot--;
    }
    if (/F(\d+)/) {
        $wpos[$_] += $way[$_] * $1 for 0 .. 1;
    }
}

say abs($pos[0]) + abs($pos[1]);
say abs($wpos[0]) + abs($wpos[1]);
