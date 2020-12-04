#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use feature 'switch';

# sed -nE '/^$/{x;:a;s/:\S+\s*/ /g;s/cid//;s/\s+/ /g;p;d};H;${g;ba}' | awk '{v += NF >= 7;} END {print v;}'
my $present = 0;
my $valid = 0;
my $this_present = 0;
my $this_valid = 0;
while (<>) {
    chomp $_;
    if (length == 0) {
        $present++ if ($this_present >= 7);
        $valid++ if ($this_valid >= 7);
        $this_present = 0;
        $this_valid = 0;
    }
    while (/(\w+):(\S+)\s*/g) {
        $this_present++ if ($1 ne 'cid');
        my $value = $2;
        for ($1) {
            when (/byr/) {$this_valid++ if ($value =~ /^\d{4}$/ and 1920 <= $value and $value <= 2002)}
            when (/iyr/) {$this_valid++ if ($value =~ /^\d{4}$/ and 2010 <= $value and $value <= 2020)}
            when (/eyr/) {$this_valid++ if ($value =~ /^\d{4}$/ and 2020 <= $value and $value <= 2030)}
            when (/hgt/) {$this_valid++ if ($value =~ /^(\d+)(cm|in)$/ and (($2 eq "cm" and 150 <= $1 and $1 <= 193) or ($2 eq "in" and 59 <= $1 and $1 <= 76)))}
            when (/hcl/) {$this_valid++ if ($value =~ /^#[0-9a-f]{6}$/)}
            when (/ecl/) {$this_valid++ if ($value =~ /^(amb|blu|brn|gry|grn|hzl|oth)$/)}
            when (/pid/) {$this_valid++ if ($value =~ /^\d{9}$/)}
        }
    }
}
$present++ if ($this_present >= 7);
$valid++ if ($this_valid >= 7);
$this_present = 0;
$this_valid = 0;

say $present;
say $valid;
