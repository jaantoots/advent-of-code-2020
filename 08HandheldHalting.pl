#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @instructions;
while (<>) {
    chomp;
    push(@instructions, ($_));
}

sub run {
    my $change = shift;
    my $can_change = 0;
    my @visited = (0) x (scalar @instructions);
    my $pos = 0;
    my $acc = 0;
    while (1) {
        last if ($pos > $#instructions or $visited[$pos]);
        $visited[$pos] = 1;
        my ($op, $arg) = split(/ /, $instructions[$pos]);
        $op =~ tr/nojm/jmno/ if ($can_change == $change);
        $can_change++ if ($op eq "jmp" or $op eq "nop");
        if ($op eq "jmp") {
            $pos += $arg;
            next;
        }
        $acc += $arg if ($op eq "acc");
        $pos++;
    }
    return ($pos, $acc);
}

say scalar run(-1);

my $right;
for (0..$#instructions) {
    my ($pos, $acc) = run($_);
    if ($pos > $#instructions) {
        $right = $acc;
        say $right;
    }
}
