#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $valid = 0;

while (<>) {
    $_ =~ /(\d+)-(\d+) (\w): (\w+)/;
    my $min = $1;
    my $max = $2;
    my $count = () = $4 =~ /\Q$3/g;
    $valid++ if ($min <= $count and $count <= $max);
}

say $valid;
