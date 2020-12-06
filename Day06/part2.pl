#!/usr/bin/perl

use warnings;
use strict;

# It's short for questionaire, you see
my %quest;
my $total = 0;
my $lines = 0;

while (<>) {
	chomp;

	# If line has data
	if (/\S/) {
		++$lines;
		foreach my $char (split('', $_)) {
			++$quest{$char};
		}
	}
	# If line is empty
	else {
		foreach my $key (keys %quest) {
			++$total if $quest{$key} == $lines;
		}
		%quest = ();
		$lines = 0;
	}
};

print "$total\n";

