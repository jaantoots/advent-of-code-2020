#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $valid = 0;
my $valid_two = 0;

while (<>) {
    $_ =~ /(\d+)-(\d+) (\w): (\w+)/;
    my $min = $1;
    my $max = $2;
    my $char = $3;
    my $pwd = $4;
    my $count = () = $pwd =~ /\Q$char/g;
    $valid++ if ($min <= $count and $count <= $max);
    $valid_two++ if (substr($pwd, $min - 1, 1) eq $char xor substr($pwd, $max - 1, 1) eq $char);
}

say $valid;
say $valid_two;
