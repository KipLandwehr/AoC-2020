#!/usr/bin/perl

use warnings;
use strict;

# It's short for "instructions," you see
my @inst;
my %seen;
my $acc = 0;

sub checkChange {
	my $i = shift;
	my $acc = shift;
	my $seen_ptr = shift;
	my %seen_copy = %{ $seen_ptr };

	for ( ; $i < @inst ; ) {
		return 0 if ($seen_copy{$i});

		++$seen_copy{$i};

		if ( $inst[$i] =~ /^nop/) {
			++$i;
			next;
		}
		if ( $inst[$i] =~ /^acc ([+-])(\d+)$/ ) {
			$acc += $2 if ($1 eq '+');
			$acc -= $2 if ($1 eq '-');
			++$i;
			next;
		}
		if ( $inst[$i] =~ /^jmp ([+-])(\d+)$/ ) {
			$i += $2 if ($1 eq '+');
			$i -= $2 if ($1 eq '-');
			next;
		}
	}

	return $acc if $i == @inst;
	# Return 0 if we broke the for loop by going too far past the end
	return 0;
}

while (<>) {
	chomp;
	push @inst, $_;
};

for (my $i=0 ; $i < @inst ; ) {
	if ($seen{$i}) {
		print "Error: found loop in main.\n";
		last;
	}

	++$seen{$i};

	if ( $inst[$i] =~ /^nop ([+-])(\d+)$/) {
		# check as jmp
		my $return;
		if ( $1 eq '+' ) {
			$return = checkChange( $i+$2, $acc, \%seen );
		}
		else {
			$return = checkChange( $i-$2, $acc, \%seen );
		}
		if ( $return ) {
			print "Answer: $return\n";
			last;
		}

		# if we still have a loop, proceed as normal
		++$i;
		next;
	}
	if ( $inst[$i] =~ /^acc ([+-])(\d+)$/ ) {
		$acc += $2 if ($1 eq '+');
		$acc -= $2 if ($1 eq '-');
		++$i;
		next;
	}
	if ( $inst[$i] =~ /^jmp ([+-])(\d+)$/ ) {
		# test as nop
		my $return = checkChange( $i+1, $acc, \%seen );
		if ( $return ) {
			print "Answer: $return\n";
			last;
		}

		# if we still have a loop, proceed as normal
		$i += $2 if ($1 eq '+');
		$i -= $2 if ($1 eq '-');
		next;
	}
}

