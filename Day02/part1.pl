#!/usr/bin/perl
use warnings;
use strict;

my $filename = "input.txt";

open INFILE, "< $filename" or die $!;

# Read input file into an array, chomping each line
## I could just read line-by-line and check, but meh
chomp (my @input = <INFILE>);

# And close the input file when done
close INFILE;

my $validPasswords = 0;

foreach ( @input ) {
	my ($range,$myChar,$string) = split(' ', $_);
	my ($lower,$upper) = split('-', $range);
	$myChar = (split('', $myChar))[0];
	my $occurences = 0;
	foreach my $char ( split('', $string) ) {
		$occurences++ if ( $char eq $myChar );
	}
	$validPasswords += 1 if ( $occurences >= $lower and $occurences <= $upper);
}

print "Valid passwords: $validPasswords\n";

