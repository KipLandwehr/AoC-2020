#!/usr/bin/perl
use warnings;
use strict;

my $filename = "input.txt";
#my $filename = "test.txt";

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
	my @string = split('', $string);

	$validPasswords += 1 if ( ($string[$lower-1] eq $myChar) xor ($string[$upper-1] eq $myChar) )
}

print "Valid passwords: $validPasswords\n";

