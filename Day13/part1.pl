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

my $soonest_depart = 0;
my $bus = 0;

foreach my $bus_id (@bus_ids) {
	next if ( $bus_id eq 'x' );

	my $cycles = int($arrival_time / $bus_id);
	my $prev_depart = ($cycles * $bus_id);
	my $next_depart = ($prev_depart + $bus_id);
	#print "$bus_id,\t$cycles\t$prev_depart\t$next_depart\t";
	if ( ($next_depart < $soonest_depart) or ($soonest_depart == 0) ) {
		$soonest_depart = $next_depart;
		$bus = $bus_id;
		#print "updated choice";
	}
	#print "\n";
}

my $wait_time = ($soonest_depart - $arrival_time);
my $answer = ($wait_time * $bus);
#print "Answer: $wait_time * $bus = $answer\n";
print "Answer: $answer\n";

