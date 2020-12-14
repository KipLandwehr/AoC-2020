#!/usr/bin/perl

use warnings;
use strict;

my @input;
my $preamble = 25;

while (<>) {
	chomp;
	push @input, $_;
};

for (my $i=$preamble ; $i < @input ; ++$i ) {
	my $target = $input[$i];

	next if checkValid($target, @input[($i-$preamble)..($i-1)]);

	# Should only hit this if we have an invalid number
	print $target, "\n";
	last;
}

sub checkValid {
	my $target = shift;
	my %match;

	while (my $entry = shift) {
		chomp $entry;
		if ($match{$entry}) {
			return 1;
		}
		else {
			++ $match{$target - $entry};
		}
	}

	# should only get here if we don't have a match
	return 0;
}
