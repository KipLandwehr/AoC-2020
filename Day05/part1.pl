#!/usr/bin/perl

use warnings;
use strict;

my $highest_seat = 0;

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

	my $sid = ($row * 8) + $col;

	$highest_seat = $sid if $sid > $highest_seat;
};

print "$highest_seat\n";

