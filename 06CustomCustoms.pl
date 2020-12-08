#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $sum = 0;
my %chars;
while (<>) {
    chomp;
    if (/^$/) {
        $sum += scalar keys %chars;
        %chars = ();
        next;
    }
    $chars{$1} = () while (/(.)/g);
}
$sum += scalar keys %chars;

say $sum;
