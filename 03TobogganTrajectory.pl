#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $trees = 0;
my $right = 3;
my $down = 1;

my $row = 0;
my $col = 0;
while (<>) {
    chomp $_;
    if ($row % $down == 0) {
        $trees++ if (substr($_, $col % length, 1) eq '#');
        $col += $right;
    }
    $row++;
}

say $trees;
