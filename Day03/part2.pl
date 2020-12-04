#!/usr/bin/perl

use warnings;
use strict;

# I'm hard coding this because it's constant and known
## I could get this programatically by checking the length of a line, but meh.
#my $len = 11;
my $len = 31;

my $row = 0;

my $trees11 = 0;
my $trees12 = 0;
my $trees31 = 0;
my $trees51 = 0;
my $trees71 = 0;

while (<>) {
	chomp;
	my @line = split('', $_);
	#print @line, "\n";
	$trees11++ if ( $line[ ($row % $len) ] eq '#' );
	$trees31++ if ( $line[ (($row * 3) % $len) ] eq '#' );
	$trees51++ if ( $line[ (($row * 5) % $len) ] eq '#' );
	$trees71++ if ( $line[ (($row * 7) % $len) ] eq '#' );
	$trees12++ if ( $row % 2 == 0 and $line[ (($row / 2) % $len) ] eq '#' );

	++$row;
}

print "$trees11, $trees31, $trees51, $trees71, $trees12\n";
print $trees11*$trees12*$trees31*$trees51*$trees71, "\n";

