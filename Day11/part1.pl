#!/usr/bin/perl

use warnings;
use strict;

my @grid;
my $rows = 0;

while (<>) {
	chomp;
	push @grid, [ split('', $_) ];
	++$rows;
};

## L := Empty Seat
## # := Occupied Seat
## . := Floor

## If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
## If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
## Otherwise, the seat's state does not change.

my $cols = @{$grid[0]};

#print "Starting Grid:\n";
#printGrid();

my $num = 1;

while ( updateGrid(scanGrid()) ) {
	#print "Iteration $num:\n";
	#printGrid();
	++$num;
};

my $finalOccupied = 0;
foreach my $row (@grid) {
	foreach my $col (@{$row}) {
		++$finalOccupied if $col eq '#';
	}
}

print "Answer: $finalOccupied\n";

sub printGrid {
	for ( my $row=0 ; $row < $rows ; ++$row ) {
		for ( my $col=0 ; $col < $cols ; ++$col ) {
			print $grid[$row][$col];
		}
		print "\n";
	}
	print "\n";
}

sub scanGrid {
	my @updates;
	for ( my $row=0 ; $row < $rows ; ++$row ) {
		for ( my $col=0 ; $col < $cols ; ++$col ) {
			next if $grid[$row][$col] eq '.';

			my $occupied = 0;
			if ( $row > 0 ) {
				if ( $col > 0 ) {
					++$occupied if ( $grid[$row-1][$col-1] eq '#' );
				}
				if ( $col < $cols-1 ) {
					++$occupied if ( $grid[$row-1][$col+1] eq '#' );
				}
				++$occupied if ( $grid[$row-1][$col] eq '#' );
			}
			if ( $row < $rows-1 ) {
				if ( $col > 0 ) {
					++$occupied if ( $grid[$row+1][$col-1] eq '#' );
				}
				if ( $col < $cols-1 ) {
					++$occupied if ( $grid[$row+1][$col+1] eq '#' );
				}
				++$occupied if ( $grid[$row+1][$col] eq '#' );
			}
			if ( $col > 0 ) {
				++$occupied if ( $grid[$row][$col-1]	and ($grid[$row][$col-1] eq '#') );
			}
			if ( $col < $cols-1 ) {
				++$occupied if ( $grid[$row][$col+1]	and ($grid[$row][$col+1] eq '#') );
			}

			if ( $grid[$row][$col] eq '#' and $occupied > 3 ) {
				push @updates, $row;
				push @updates, $col;
			}
			if ( $grid[$row][$col] eq 'L' and $occupied == 0 ) {
				push @updates, $row;
				push @updates, $col;
			}
		}
	}
	return @updates;
}

sub updateGrid {
	return 0 if ( @_ == 0 );

	while ( @_ ) {
		my $row = shift;
		my $col = shift;

		if ( $grid[$row][$col] eq '#' ) {
			$grid[$row][$col] = 'L';
		}
		elsif ( $grid[$row][$col] eq 'L' ) {
			$grid[$row][$col] = '#';
		}
		else {
			print "Error: floor tile passed to updateGrid.\n";
		}
	}
	return 1;
}

