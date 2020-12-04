#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @trees = (0) x 5;
my @right = (1, 3, 5, 7, 1);
my @down = (1, 1, 1, 1, 2);

my $row = 0;
my @col = (0) x 5;
while (<>) {
    chomp $_;
    for (my $i = 0; $i < 5; $i++) {
        if ($row % $down[$i] == 0) {
            $trees[$i]++ if (substr($_, $col[$i] % length, 1) eq '#');
            $col[$i] += $right[$i];
        }
        $row++;
    }
}

my $prod = 1;
$prod *= $_ foreach (@trees);

say $trees[1];
say $prod;
