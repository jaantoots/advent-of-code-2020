#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $highest = 0;
my $lowest = 128 * 8;
my @taken = (0) x (128 * 8);
while (<>) {
    chomp;
    tr/FBLR/0101/;
    my $id = oct("0b".$_);
    $taken[$id] = 1;
    $highest = $id if $id > $highest;
    $lowest = $id if $id < $lowest;
}
my $my = $lowest + 1;
while ($my < $highest) {
    last if (!$taken[$my]);
    $my++;
}

say $highest;
say $my;
