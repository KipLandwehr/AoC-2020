#!/usr/bin/perl

use warnings;
use strict;

my $valid_passports = 0;
my %passport;

while (<>) {
	chomp;

	# If the line has non-whitespace chars (i.e. data)
	if (/\S/) {
		foreach my $field (split(' ', $_)) {
			my ($key,$value) = split(':', $field);
			$passport{$key} = $value;
		}
	}
	else {
		# Found empty line, so see if the passport is valid
		if ( keys %passport == 8 ) { ++$valid_passports; }
		elsif ( keys %passport == 7 and not $passport{"cid"} ) { ++$valid_passports; }

		# Now reset the passport hash to empty
		%passport = ();
	}

};

print "$valid_passports\n";

