#!/usr/bin/perl

use warnings;
use strict;

use List::Util qw(sum0);

my @input;
my @diffs;

while (<>) {
	chomp;
	push @input, $_;
};

@input = sort { $a <=> $b } @input;
# Add the built-in converter
push @input, ($input[@input-1]+3);

# This works to represent the wall outlet
my $prev = 0;
my $consecutiveOnes = 0;
my $answer = 1;

foreach my $num (@input) {
	my $diff = $num - $prev;

	if ( $diff == 1 ) {
		++$consecutiveOnes;
	}
	else {
		if ( $consecutiveOnes > 1 ) {
			my $combinations = (2**($consecutiveOnes-1)) - sum0(0..($consecutiveOnes-3));
			$answer *= $combinations;
		}
		$consecutiveOnes = 0;
	}
	$prev = $num;
}

print "Answer: ", $answer, "\n";

