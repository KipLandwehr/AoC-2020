#!/usr/bin/perl

use warnings;
use strict;

my @inst;
my %seen;
my $acc = 0;

while (<>) {
	chomp;
	push @inst, $_;
};

for (my $i=0 ; $i < @inst ; ) {
	if ($seen{$i}) {
		print "$acc\n";
		last;
	}

	++$seen{$i};

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

