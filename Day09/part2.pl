#!/usr/bin/perl

use warnings;
use strict;

use List::MoreUtils qw( minmax );


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
	my $answer = findWeakness( $target );
	print $answer, "\n";
	last;
}

sub sumList {
	my $total = 0;
	foreach my $num (@_) {
		$total += $num;
	}
	return $total;
}

sub findWeakness {
	my $target = shift;
	for ( my ($i,$j) = (0,1) ; $j < @input ; ) {
		if ( $i == $j ) {
			++$j;
			next;
		}
		my @range = @input[$i..$j];
		my $total = sumList( @range );

		if ( $total == $target ) {
			my ($min, $max) = minmax @range;
			return ($min + $max);
		}

		if ( $total < $target ) {
			++$j;
			next;
		}
		else {
			++$i;
		}
	}
	# If we ever get here, then something is wrong
	die "Error: reached end of input with no match.\n";
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
