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
	# If the line is blank (i.e. we found the end of the current passport)
	else {
		# No need checking any fields if the 7 required aren't present
		if ( keys %passport < 7 or (keys %passport == 7 and $passport{"cid"}) ) {
			%passport = ();
			next;
		}

		#byr (Birth Year) - four digits; at least 1920 and at most 2002.
		if (( $passport{"byr"} > 1919 and $passport{"byr"} < 2003 )
		#iyr (Issue Year) - four digits; at least 2010 and at most 2020.
		and ( $passport{"iyr"} > 2009 and $passport{"iyr"} < 2021 )
		#eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
		and ( $passport{"eyr"} > 2019 and $passport{"eyr"} < 2031 )
		#hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
		and ( $passport{"hcl"} =~ /^#[0-9a-f]{6}$/ )
		#ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
		and ( $passport{"ecl"} =~ /^(amb|blu|brn|gry|grn|hzl|oth)$/ )
		#pid (Passport ID) - a nine-digit number, including leading zeroes.
		and ( $passport{"pid"} =~ /^\d{9}$/ ))
		{
			#hgt (Height) - a number followed by either cm or in:
			#    If cm, the number must be at least 150 and at most 193.
			#    If in, the number must be at least 59 and at most 76.
			if ( $passport{"hgt"} =~ /^(\d+)(cm|in)$/ ) {
				if (( $2 eq "cm" and $1 > 149 and $1 < 194 )
				or ( $2 eq "in" and $1 > 58 and $1 < 77 ))
				{
					++$valid_passports;
				}
			}
		}
		#cid (Country ID) - ignored, missing or not.

		# Now reset the passport hash to empty
		%passport = ();
	}

};

print "$valid_passports\n";

