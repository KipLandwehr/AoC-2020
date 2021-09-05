#!/usr/bin/perl

use warnings;
use strict;

my @mask = ();
my %mem;

while (<>) {
	chomp;
	if ( $_ =~ /^(mask = )([X01]{36})$/ ) {
		@mask = split( //, $2 );
	}
	elsif ( $_ =~ /^(mem\[)([\d]+)(\] = )([\d]+)$/ ) {
		my $addr = $2;

		my $val_dec = $4;
		my $val_bin = sprintf( "%.36b", $val_dec );
		my @bits = split( //, $val_bin );
		for (my $f = 0; $f < @bits; ++$f) {
			unless ( $mask[$f] eq 'X' ) {
				$bits[$f] = $mask[$f];
			}
		}
		$val_bin = join( "", @bits );
		$val_dec = oct( "0b$val_bin" );

		$mem{$addr} = $val_dec;
	}
	else {
		die "Invalid input\n";
	}
};

my $answer = 0;

for (keys %mem) {
	$answer += $mem{$_};
}

print "Answer: $answer\n";

