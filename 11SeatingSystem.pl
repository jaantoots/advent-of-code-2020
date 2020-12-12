#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @seats;
while (<>) {
    chomp;
    push @seats, [split //];
}

my $changes = -1;
sub new {
    my ($row, $col) = @_;
    my $state = $seats[$row][$col];
    return $state if $state eq '.';
    my $occupied = 0;
    for my $i (($row - 1) .. ($row + 1)) {
        next if $i < 0 or $i > $#seats;
        for my $j (($col - 1) .. ($col + 1)) {
            next if $j < 0 or $j > $#{$seats[$i]};
            next if $i == $row and $j == $col;
            $occupied++ if $seats[$i][$j] eq '#';
        }
    }
    $changes++;
    return '#' if $state eq 'L' and $occupied == 0;
    return 'L' if $state eq '#' and $occupied >= 4;
    $changes--;
    return $state;
}

my $iterations = 0;
sub evolve {
    my @new;
    $changes = 0;
    for my $i (0 .. $#seats) {
        my @row = map { new($i, $_) } (0 .. $#{$seats[$i]});
        push @new, [@row];
    }
    @seats = @new;
    $iterations++;
}

evolve() until $changes == 0;

my $occupied = 0;
$occupied += join('', @{$_}) =~ tr/#// for (@seats);
say $occupied;
