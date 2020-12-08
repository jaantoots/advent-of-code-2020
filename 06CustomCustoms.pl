#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $sum = 0;
my $suma = 0;
my %chars;
my $all;
while (<>) {
    chomp;
    if (/^$/) {
        $sum += scalar keys %chars;
        %chars = ();
        $suma += length $all;
        $all = undef;
        next;
    }
    $all = $_ unless (defined $all);
    $all =~ s/[^\Q$_\E]//g;
    $chars{$1} = () while (/(.)/g);
}
$sum += scalar keys %chars;
$suma += length $all;

say $sum;
say $suma;
