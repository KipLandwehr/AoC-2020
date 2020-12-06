#!/usr/bin/perl

use warnings;
use strict;

# It's short for questionaire, you see
my %quest;
my $total = 0;

while (<>) {
	chomp;

	# If line has data
	if (/\S/) {
		foreach my $char (split('', $_)) {
			++$quest{$char};
		}
	}
	# If line is empty
	else {
		$total += keys %quest;
		%quest = ();
	}
};

print "$total\n";

