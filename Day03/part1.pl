#!/usr/bin/perl

use warnings;
use strict;

# I'm hard coding this because it's constant and known
## I could get this programatically by checking the length of a line, but meh.
my $len = 31;

my $pos = 0;
my $trees = 0;

while (<>) {
	chomp;
	$trees++ if ( (split('', $_))[($pos % $len)] eq '#' );
	$pos += 3;
};

print "$trees\n";

