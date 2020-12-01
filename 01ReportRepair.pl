#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $n = 2020;
my @entries = (0) x ($n + 1);
my @sums = (0) x ($n + 1);

my $two = 0;
my $three = 0;

while (<>) {
    if ($entries[2020 - $_]) {
        $two = $_ * (2020 - $_);
    }
    if ($sums[2020 - $_]) {
        $three = $_ * $sums[2020 - $_];
    }
    for (my $i = 0; $i <= 2020 - $_; $i++) {
        if ($entries[$i]) {
            $sums[$_ + $i] = $_ * $i;
        }
    }
    $entries[$_] = 1;
}

say $two;
say $three;
