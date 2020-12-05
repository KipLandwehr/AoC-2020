#!/usr/bin/perl

use warnings;
use strict;

my @seats;

while (<>) {
	chomp;
	my ($row, $col) = /^([FB]{7})([LR]{3})$/ or do {
		warn "Invalid input: $_\n";
		next;
	};
	$row =~ tr/FB/01/;
	$row = oct("0b".$row);
	$col =~ tr/LR/01/;
	$col = oct("0b".$col);

	push( @seats, (($row * 8)+$col) );
};

@seats = sort { $a <=> $b } @seats;

# Pick arbitrarily low number, that won't be 0 (lowest possible seat ID) minus 2
my $previousSID = -10;

foreach my $sid ( @seats ) {
	if ( ($sid-2) == $previousSID ) {
		print $sid-1, "\n";
		last;
	}
	else {
		$previousSID = $sid;
	}
}

