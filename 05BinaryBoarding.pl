#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $highest = 0;
while (<>) {
    chomp $_;
    my $row = substr($_, 0, 7);
    $row =~ tr/FB/01/;
    $row = oct("0b".$row);
    my $col = substr($_, 7, 3);
    $col =~ tr/LR/01/;
    $col = oct("0b".$col);
    my $id = $row * 8 + $col;
    $highest = $id if $id > $highest;
}

say $highest;
