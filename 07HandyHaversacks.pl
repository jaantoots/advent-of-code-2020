#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my %contains;
while (<>) {
    chomp;
    /^(\w+ \w+)/;
    my $outer = $1;
    while (/\d+ (\w+ \w+)/g) {
        $contains{$1} = [] unless defined $contains{$1};
        push(@{$contains{$1}}, ($outer));
    }
}

my %contain_sg;
sub find {
    my $bag = shift;
    foreach my $outer (@{$contains{$bag}}) {
        unless (defined $contain_sg{$outer}) {
            $contain_sg{$outer} = 1;
            find($outer);
        }
    }
}
find("shiny gold");

say scalar keys %contain_sg;
