#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my %contains;
my %contained_by;
while (<>) {
    chomp;
    /^(\w+ \w+)/;
    my $outer = $1;
    $contained_by{$outer} = {};
    while (/(\d+) (\w+ \w+)/g) {
        $contains{$2} = [] unless defined $contains{$2};
        push(@{$contains{$2}}, ($outer));
        $contained_by{$outer}{$2} = $1;
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

sub find_by {
    my $bag = shift;
    my $num = 0;
    foreach my $inner (keys %{$contained_by{$bag}}) {
        $num += $contained_by{$bag}{$inner} * (1 + find_by($inner));
    }
    return $num;
}

say scalar keys %contain_sg;
say find_by("shiny gold");
