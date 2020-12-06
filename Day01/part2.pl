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
my $length = @input_sorted;

for ( my ($i, $found_values) = (0, 0) ; ($i < $length-1) and !$found_values ; $i++ ) {
	my $diff = 2020 - $input_sorted[$i];
	for ( my ($j, $k) = (($i+1), $length-1); $j < $k; ) {
		my $sum = $input_sorted[$j] + $input_sorted[$k];
		if ( $sum == $diff ) {
			print "$input_sorted[$i], $input_sorted[$j], $input_sorted[$k]\n";
			print $input_sorted[$i]*$input_sorted[$j]*$input_sorted[$k], "\n";
			++$found_values;
			last;
		}
		elsif ( $sum > $diff) {
			--$k;
		}
		else {
			++$j;
		}
	}
}

