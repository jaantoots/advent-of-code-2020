#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my @fields = qw(byr iyr eyr hgt hcl ecl pid cid);
# sed -nE '/^$/{x;:a;s/:\S+\s*/ /g;s/cid//;s/\s+/ /g;p;d};H;${g;ba}' | awk '{v += NF >= 7;} END {print v;}'
my $valid = 0;
my $this = 0;
while (<>) {
    chomp $_;
    if (length == 0) {
        $valid++ if ($this >= 7);
        $this = 0;
    }
    while (/(\w+):\S+\s*/g) {
        $this++ if ($1 ne 'cid');
    }
}
$valid++ if ($this >= 7);

say $valid;
