#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @adapters = (0);
while (<>) {
    chomp;
    push(@adapters, ($_));
}
my @sadapters = sort {$a <=> $b} @adapters;

my @diff = (0) x 3;
for (my $i = 0; $i < $#sadapters; $i++) {
    $diff[$sadapters[$i + 1] - $sadapters[$i] - 1]++;
}
$diff[2]++;
say $diff[0] * $diff[2];

my @ways = (0) x (scalar @sadapters);
sub _ways {
    my $idx = shift;
    return 1 if $idx == $#sadapters;
    my $this = $sadapters[$idx];
    my $value = 0;
    for (my $i = $idx + 1; $i <= $#sadapters; $i++) {
        last if $sadapters[$i] - $this > 3;
        $value += ways($i);
    }
    return $value;
}
sub ways {
    my $idx = shift;
    return $ways[$idx] if $ways[$idx] > 0;
    $ways[$idx] = _ways($idx);
    return $ways[$idx];
}
say ways(0);
