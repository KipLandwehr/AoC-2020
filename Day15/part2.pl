#!/usr/bin/perl

use warnings;
use strict;

my %numbers;
my $turn = 1;

while (<>) {
	chomp;
	my @tmp = (split ( ',', $_ ));
	foreach my $item ( @tmp ) {
		$numbers{$item} = $turn;
		++$turn;
	}
};

#All examples, and my input, will start with the next number being Zero.
my $diff = 0;

while ( $turn < 30000000 ) {
	my $new_diff = 0;
	if ( defined $numbers{$diff} ) {
		$new_diff = $turn - $numbers{$diff};
	}
	$numbers{$diff} = $turn;
	$diff = $new_diff;
	++$turn;
}

# After the loop ends, the next number to be spoken should be the 2020th
print "Answer: $diff\n";

