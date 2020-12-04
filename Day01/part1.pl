#!/usr/bin/perl
use warnings;
use strict;

my $filename = "input.txt";

open INFILE, "< $filename" or die $!;

# Read input file into an array, chomping each line
chomp (my @input = <INFILE>);

# And close the input file when done
close INFILE;

# Sort the array numerically
## Default sort is alphabetical in ASCII order
## '{ $a <=> $b }' specifies numerical sort.
my @input_sorted = sort { $a <=> $b } @input;


# Find the values that add to 2020;
## Initial values are 0 because 0, and 3000 because it's greater than 2020
my $lowerValue = shift(@input_sorted);
my $upperValue = pop(@input_sorted);

while ( $lowerValue + $upperValue != 2020 ) {
	my $sum = $lowerValue + $upperValue;

	# If our sum is too low, go up one value on the low side
	if ( $sum < 2020 ) {
		$lowerValue = shift(@input_sorted);
	}
	# If our sum is too high, go down one value on the high side
	elsif ( $sum > 2020 ) {
		$upperValue = pop(@input_sorted);
	}
}

# We should have our values now

# Muliply them for the solution
my $product = $lowerValue * $upperValue;

# Print solution
print "Solution: $product\n";

