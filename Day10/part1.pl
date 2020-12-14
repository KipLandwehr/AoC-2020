#!/usr/bin/perl

use warnings;
use strict;

my @input;
my %diffs;

while (<>) {
	chomp;
	push @input, $_;
};

@input = sort { $a <=> $b } @input;

my $prev = 0;

foreach my $num (@input) {
	my $diff = $num - $prev;

	++$diffs{1} if $diff == 1;
	++$diffs{2} if $diff == 2;
	++$diffs{3} if $diff == 3;

	$prev = $num;
}

# To account for the device's built-in adapter
++$diffs{3};

print $diffs{1}*$diffs{3}, "\n";

