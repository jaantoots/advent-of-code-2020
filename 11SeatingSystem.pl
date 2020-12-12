#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @layout;
while (<>) {
    chomp;
    push @layout, [split //];
}

my @seats = @layout;
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


my @sseats = @layout;
my $schanges = -1;
sub snew {
    my ($row, $col) = @_;
    my $state = $sseats[$row][$col];
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
                last if $ii < 0 or $ii > $#sseats;
                last if $jj < 0 or $jj > $#{$sseats[$ii]};
                my $this = $sseats[$ii][$jj];
                next if $this eq '.';
                last if $this eq 'L';
                $occupied++ if $this eq '#';
                last;
            }
        }
    }
    $schanges++;
    return '#' if $state eq 'L' and $occupied == 0;
    return 'L' if $state eq '#' and $occupied >= 5;
    $schanges--;
    return $state;
}

my $siterations = 0;
sub sevolve {
    my @new;
    $schanges = 0;
    for my $i (0 .. $#sseats) {
        my @row = map { snew($i, $_) } (0 .. $#{$sseats[$i]});
        push @new, [@row];
    }
    @sseats = @new;
    $siterations++;
}
sevolve() until $schanges == 0;

my $soccupied = 0;
$soccupied += join('', @{$_}) =~ tr/#// for (@sseats);
say $soccupied;
