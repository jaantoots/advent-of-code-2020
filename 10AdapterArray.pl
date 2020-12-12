#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @adapters = (0);
while (<>) {
    chomp;
    push(@adapters, ($_));
}
my @sadapters = sort {$a <=> $b} @adapters;

my @diff = (0) x 3;
for (my $i = 0; $i < $#sadapters; $i++) {
    $diff[$sadapters[$i + 1] - $sadapters[$i] - 1]++;
}
$diff[2]++;

say $diff[0] * $diff[2];
