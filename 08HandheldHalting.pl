#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @instructions;
while (<>) {
    chomp;
    push(@instructions, ($_));
}

my @visited = (0) x (scalar @instructions);
my $pos = 0;
my $acc = 0;
while (1) {
    last if $visited[$pos];
    $visited[$pos] = 1;
    my ($op, $arg) = split(/ /, $instructions[$pos]);
    if ($op eq "jmp") {
        $pos += $arg;
        next;
    }
    $acc += $arg if ($op eq "acc");
    $pos++;
}

say $acc;
