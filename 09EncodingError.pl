#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @numbers;
my @sums;
while (<>) {
    chomp;
    push(@numbers, ($_));
    for (my $i = 0; $i < $#numbers; $i++) {
        push(@{$sums[$i]}, ($numbers[$i] + $_));
    }
    next if (scalar @numbers <= 25);
    my $found = 0;
    LOOP: for my $sums (@sums) {
        for my $sum (@$sums) {
            if ($sum eq $_) {
                $found = 1;
                last LOOP;
            }
        }
    }
    unless ($found) {
        say $_;
        last;
    }
    shift @numbers;
    shift @sums;
}
