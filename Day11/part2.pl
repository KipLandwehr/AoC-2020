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
## If a seat is occupied (#) and five or more seats adjacent to it are also occupied, the seat becomes empty.
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
			++$occupied if checkE($row, $col+1);
			++$occupied if checkN($row-1, $col);
			++$occupied if checkNE($row-1, $col+1);
			++$occupied if checkNW($row-1, $col-1);
			++$occupied if checkS($row+1, $col);
			++$occupied if checkSE($row+1, $col+1);
			++$occupied if checkSW($row+1, $col-1);
			++$occupied if checkW($row, $col-1);

			#print "($row, $col) -> $occupied\n";
			if ( $grid[$row][$col] eq '#' and $occupied > 4 ) {
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
	# No updates to make. End sim and count seats.
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

sub checkInBounds {
	my $row = shift;
	my $col = shift;

	if ( ( $row < 0 ) or ( $row >= $rows ) or ( $col < 0 ) or ( $col >= $cols ) ) {
		return 0;
	}
	else {
		return 1;
	}
}

sub checkE {
	my $row = shift;
	my $col = shift;

	# If we're off the grid, no occupied adjacent seat
	if ( not checkInBounds($row, $col) ) {
		return 0;
	}
	# Otherwise, if it's a floor tile, check next tile
	elsif ( $grid[$row][$col] eq '.' ) {
		return checkE($row, $col+1);
	}
	# Otherwise, if the seat tile is empty, no occupied adjacent seat
	elsif ( $grid[$row][$col] eq 'L' ) {
		return 0;
	}
	# Otherwise, if the seat tile is filled, occupied adjacent seat
	elsif ( $grid[$row][$col] eq '#' ) {
		return 1;
	}
	else {
		print "Error in checkE.\n";
	}
}
sub checkN {
	my $row = shift;
	my $col = shift;

	# If we're off the grid, no occupied adjacent seat
	if ( not checkInBounds($row, $col) ) {
		return 0;
	}
	# Otherwise, if it's a floor tile, check next tile
	elsif ( $grid[$row][$col] eq '.' ) {
		return checkN($row-1, $col);
	}
	# Otherwise, if the seat tile is empty, no occupied adjacent seat
	elsif ( $grid[$row][$col] eq 'L' ) {
		return 0;
	}
	# Otherwise, if the seat tile is filled, occupied adjacent seat
	elsif ( $grid[$row][$col] eq '#' ) {
		return 1;
	}
	else {
		print "Error in checkN.\n";
	}
}
sub checkNE {
	my $row = shift;
	my $col = shift;

	# If we're off the grid, no occupied adjacent seat
	if ( not checkInBounds($row, $col) ) {
		return 0;
	}
	# Otherwise, if it's a floor tile, check next tile
	elsif ( $grid[$row][$col] eq '.' ) {
		return checkNE($row-1, $col+1);
	}
	# Otherwise, if the seat tile is empty, no occupied adjacent seat
	elsif ( $grid[$row][$col] eq 'L' ) {
		return 0;
	}
	# Otherwise, if the seat tile is filled, occupied adjacent seat
	elsif ( $grid[$row][$col] eq '#' ) {
		return 1;
	}
	else {
		print "Error in checkNE.\n";
	}
}
sub checkNW {
	my $row = shift;
	my $col = shift;

	# If we're off the grid, no occupied adjacent seat
	if ( not checkInBounds($row, $col) ) {
		return 0;
	}
	# Otherwise, if it's a floor tile, check next tile
	elsif ( $grid[$row][$col] eq '.' ) {
		return checkNW($row-1, $col-1);
	}
	# Otherwise, if the seat tile is empty, no occupied adjacent seat
	elsif ( $grid[$row][$col] eq 'L' ) {
		return 0;
	}
	# Otherwise, if the seat tile is filled, occupied adjacent seat
	elsif ( $grid[$row][$col] eq '#' ) {
		return 1;
	}
	else {
		print "Error in checkNW.\n";
	}
}
sub checkS {
	my $row = shift;
	my $col = shift;

	# If we're off the grid, no occupied adjacent seat
	if ( not checkInBounds($row, $col) ) {
		return 0;
	}
	# Otherwise, if it's a floor tile, check next tile
	elsif ( $grid[$row][$col] eq '.' ) {
		return checkS($row+1, $col);
	}
	# Otherwise, if the seat tile is empty, no occupied adjacent seat
	elsif ( $grid[$row][$col] eq 'L' ) {
		return 0;
	}
	# Otherwise, if the seat tile is filled, occupied adjacent seat
	elsif ( $grid[$row][$col] eq '#' ) {
		return 1;
	}
	else {
		print "Error in checkS.\n";
	}
}
sub checkSE {
	my $row = shift;
	my $col = shift;

	# If we're off the grid, no occupied adjacent seat
	if ( not checkInBounds($row, $col) ) {
		return 0;
	}
	# Otherwise, if it's a floor tile, check next tile
	elsif ( $grid[$row][$col] eq '.' ) {
		return checkSE($row+1, $col+1);
	}
	# Otherwise, if the seat tile is empty, no occupied adjacent seat
	elsif ( $grid[$row][$col] eq 'L' ) {
		return 0;
	}
	# Otherwise, if the seat tile is filled, occupied adjacent seat
	elsif ( $grid[$row][$col] eq '#' ) {
		return 1;
	}
	else {
		print "Error in checkSE.\n";
	}
}
sub checkSW {
	my $row = shift;
	my $col = shift;

	# If we're off the grid, no occupied adjacent seat
	if ( not checkInBounds($row, $col) ) {
		return 0;
	}
	# Otherwise, if it's a floor tile, check next tile
	elsif ( $grid[$row][$col] eq '.' ) {
		return checkSW($row+1, $col-1);
	}
	# Otherwise, if the seat tile is empty, no occupied adjacent seat
	elsif ( $grid[$row][$col] eq 'L' ) {
		return 0;
	}
	# Otherwise, if the seat tile is filled, occupied adjacent seat
	elsif ( $grid[$row][$col] eq '#' ) {
		return 1;
	}
	else {
		print "Error in checkSW.\n";
	}
}
sub checkW {
	my $row = shift;
	my $col = shift;

	# If we're off the grid, no occupied adjacent seat
	if ( not checkInBounds($row, $col) ) {
		return 0;
	}
	# Otherwise, if it's a floor tile, check next tile
	elsif ( $grid[$row][$col] eq '.' ) {
		return checkW($row, $col-1);
	}
	# Otherwise, if the seat tile is empty, no occupied adjacent seat
	elsif ( $grid[$row][$col] eq 'L' ) {
		return 0;
	}
	# Otherwise, if the seat tile is filled, occupied adjacent seat
	elsif ( $grid[$row][$col] eq '#' ) {
		return 1;
	}
	else {
		print "Error in checkW.\n";
	}
}
