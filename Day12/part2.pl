#!/usr/bin/perl

use warnings;
use strict;

my $ship_x = 0;
my $ship_y = 0;

# The starting waypoint is 10 E, 1 N
my $waypoint_x = 10;
my $waypoint_y = 1;


while (<>) {
	chomp;
	my ($inst, $val) = /^([NSEWLRF]{1})(\d*)$/ or do {
		warn "Invalid input: $_\n";
		next;
	};

	if ( $inst eq 'R' ) {
		my $rot_steps = (($val / 90) % 4);
		rotate($rot_steps);
	}
	if ( $inst eq 'L' ) {
		# This is convoluted but...
		# Reduce the degree value to number of 90 degree turns
		# Reduce those to a number of steps between from 0 to 3 (modulo 4)
		# Subtract from 4 to convert from CCW rotation to CC rotation
		# Modulo 4 again, because I'd rather do 0 rotations than 4, but not strictly necessary
		my $rot_steps = ((4 - (($val / 90) % 4)) % 4);
		rotate($rot_steps);
	}
	if ( $inst eq 'F' ) {
		$ship_x += ($val * $waypoint_x);
		$ship_y += ($val * $waypoint_y);
	}
	if ( $inst eq 'E' ) { $waypoint_x += $val; }
	if ( $inst eq 'S' ) { $waypoint_y -= $val; }
	if ( $inst eq 'W' ) { $waypoint_x -= $val; }
	if ( $inst eq 'N' ) { $waypoint_y += $val; }
};

my $dist = abs($ship_x) + abs($ship_y);

print "Manhattan distance = $dist\n";

sub rotate {
	#  2,  1
	#  1, -2
	# -2, -1
	# -1,  2
	my $steps = shift;

	for ( my $num = 0; $num < $steps; ++$num ) {
		my $tmp = $waypoint_x;
		$waypoint_x = $waypoint_y;
		$waypoint_y = ($tmp * -1);
	}
}
