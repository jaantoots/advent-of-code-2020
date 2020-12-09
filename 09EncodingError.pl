#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @numbers;
my @sums;
my $invalid;
my @all_numbers;
while (<>) {
    chomp;
    push(@numbers, ($_));
    push(@all_numbers, ($_));
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
    unless ($found or defined $invalid) {
        $invalid = $_;
    }
    shift @numbers;
    shift @sums;
}

say $invalid;

my $i;
my $j;
LOOP: for ($i = 0; $i <= $#all_numbers; $i++) {
    my $sum = 0;
    for ($j = $i; $j <= $#all_numbers; $j++) {
        $sum += $all_numbers[$j];
        last LOOP if ($sum == $invalid);
    }
}
my $min = $all_numbers[$i];
my $max = $all_numbers[$i];
for (@all_numbers[$i..$j]) {
    $min = $_ if ($_ < $min);
    $max = $_ if ($_ > $max);
}

say $min + $max;
