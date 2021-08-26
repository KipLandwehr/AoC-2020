#!/usr/bin/perl

use warnings;
use strict;

my $linenum = 0;
my $arrival_time = 0;
my @bus_ids;

while (<>) {
	chomp;
	if ( $linenum == 0 ) {
		$arrival_time = $_
	}
	else {
		@bus_ids = split(',', $_);
	}
	++$linenum;
};

my $index = 0;
my $answer = 0;
my $step = 1;

for ( my $index = 0 ; $index < @bus_ids ; $index++ ) {
	my $bus_id = $bus_ids[$index];
	#print "Index: $index\tBus ID: $bus_id\n";
	next if ( $bus_id eq 'x' );
	my $remainder = ($bus_id - $index) % $bus_id;
	while ( ($answer % $bus_id) != $remainder ) {
		$answer += $step;
		#print "Answer: $answer\n";
	}
	$step *= $bus_id;
	#print "Step: $step\n";
}

print "Answer: $answer\n";


# Obviously this method won't work on the actual puzzle, but it was a fun exercise
#for ( my $time = 0; $index < @bus_ids ; $time++ ) {
#
#	#print "Time: $time\n";
#
#	# If we're out of buses, then we've found our answer
#	#last if ( $index > $#bus_ids );
#
#	if ( $time % 1000000 == 0 ) {
#		print "Time: $time\n";
#	}
#
#	# If the current bus ID is not given, we don't care, move to next index
#	if ( $bus_ids[$index] eq 'x' ) {
#		++$index;
#		next;
#	}
#	# Otherwise, we have a real bus ID and need to do some checking.
#
#	# If time is a multiple of the bus ID
#	if ( ($time % $bus_ids[$index]) == 0 ) {
#		#print "Hit bus ID $bus_ids[$index] at time $time\n";
#		# Set answer equal to time if we're at index 0
#		if ( $index == 0 ) {
#			$answer = $time;
#			#print "Set answer to $answer\n";
#		}
#	}
#	# Otherwise, we don't have our answer and need to reset and keep looking
#	else {
#		# Reset index to 0 and start over
#		$index = 0;
#		#print "Reset index at time $time\n";
#		next;
#	}
#
#	++$index;
#}
#
#print "Answer: $answer\n";

