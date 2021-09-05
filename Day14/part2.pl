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
		my $addr_dec = $2;
		my $val_dec = $4;

		my $addr_bin = sprintf( "%.36b", $addr_dec );
		my @bits = split( //, $addr_bin );
		for (my $f = 0; $f < @bits; ++$f) {
			unless ( $mask[$f] eq '0' ) {
				$bits[$f] = $mask[$f];
			}
		}

		my @addresses = ();
		for ( my $bit = 0; $bit < @bits; ++$bit ) {
			next unless ( $bits[$bit] eq 'X' );
			if ( @addresses == 0 ) {
				my @tmp1 = @bits;
				my @tmp2 = @bits;
				$tmp1[$bit] = 0;
				$tmp2[$bit] = 1;
				@addresses = ( \@tmp1, \@tmp2 );
			}
			else {
				my @new_addresses = ();
				foreach my $addr ( @addresses ) {
					my @tmp1 = @$addr;
					my @tmp2 = @$addr;
					$tmp1[$bit] = 0;
					$tmp2[$bit] = 1;
					push ( @new_addresses, (\@tmp1, \@tmp2) );
				}
				@addresses = @new_addresses;
			}
		}
		foreach my $addr ( @addresses ) {
			$addr_bin = join( "", @$addr );
			$addr_dec = oct( "0b$addr_bin" );

			$mem{$addr_dec} = $val_dec;
		}
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

