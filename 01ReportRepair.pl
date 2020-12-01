#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $n = 2020;
my @array = (0) x ($n + 1);

while (<>) {
    if ($array[2020 - $_]) {
        say $_ * (2020 - $_);
        last;
    }
    $array[$_] = 1;
}
