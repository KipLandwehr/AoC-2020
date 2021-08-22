#!/usr/bin/perl

use warnings;
use strict;

my $xcoord = 0;
my $ycoord = 0;
my $dir = 0;

# The starting direction is East...
# E = 0
# S = 1
# W = 2
# N = 3

while (<>) {
	chomp;
	my ($inst, $val) = /^([NSEWLRF]{1})(\d*)$/ or do {
		warn "Invalid input: $_\n";
		next;
	};

	if ( $inst eq 'R' ) {
		my $rot_steps = ($val / 90);
		$dir = (($dir + $rot_steps) % 4)
	}
	if ( $inst eq 'L' ) {
		my $rot_steps = ($val / 90);
		$dir -= $rot_steps;
		# Direction could be negative now.
		# Adding full rotations of four until value is 0 or positive
		# preserves direction and gets us to a desired positive value.
		while ( $dir < 0 ) {
			$dir += 4;
		}
	}
	if ( $inst eq 'F' ) { move($dir, $val); }
	if ( $inst eq 'E' ) { move(0, $val); }
	if ( $inst eq 'S' ) { move(1, $val); }
	if ( $inst eq 'W' ) { move(2, $val); }
	if ( $inst eq 'N' ) { move(3, $val); }
};

my $dist = abs($xcoord) + abs($ycoord);

print "Manhattan distance = $dist\n";

sub move {
	my $dir = shift;
	my $val = shift;

	$xcoord += $val if ( $dir == 0 );
	$ycoord -= $val if ( $dir == 1 );
	$xcoord -= $val if ( $dir == 2 );
	$ycoord += $val if ( $dir == 3 );
}
