#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @layout;
while (<>) {
    chomp;
    push @layout, [split //];
}
my $changes;

my $new = sub {
    my ($sref, $row, $col) = @_;
    my @seats = @$sref;
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
};

sub evolve {
    my ($sref, $newref) = @_;
    my @seats = @$sref;
    my @new;
    $changes = 0;
    for my $i (0 .. $#seats) {
        my @row = map { &$newref(\@seats, $i, $_) } (0 .. $#{$seats[$i]});
        push @new, [@row];
    }
    return @new;
}

my @seats;

@seats = @layout;
$changes = -1;
@seats = evolve(\@seats, $new) until $changes == 0;

my $occupied = 0;
$occupied += join('', @{$_}) =~ tr/#// for (@seats);
say $occupied;


my $snew = sub {
    my ($sref, $row, $col) = @_;
    my @seats = @$sref;
    my $state = $seats[$row][$col];
    return $state if $state eq '.';
    my $occupied = 0;
    for my $i (-1 .. 1) {
        for my $j (-1 .. 1) {
            next if $i == 0 and $j == 0;
            my $ii = $row;
            my $jj = $col;
            while (1) {
                $ii += $i;
                $jj += $j;
                last if $ii < 0 or $ii > $#seats;
                last if $jj < 0 or $jj > $#{$seats[$ii]};
                my $this = $seats[$ii][$jj];
                next if $this eq '.';
                last if $this eq 'L';
                $occupied++ if $this eq '#';
                last;
            }
        }
    }
    $changes++;
    return '#' if $state eq 'L' and $occupied == 0;
    return 'L' if $state eq '#' and $occupied >= 5;
    $changes--;
    return $state;
};

@seats = @layout;
$changes = -1;
@seats = evolve(\@seats, $snew) until $changes == 0;

my $soccupied = 0;
$soccupied += join('', @{$_}) =~ tr/#// for (@seats);
say $soccupied;
