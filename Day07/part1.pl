#!/usr/bin/perl

use warnings;
use strict;

my %bagsHoldingColor;
my $target = pop;

sub findContainers {
	my $color = shift;
	my %containers = ();
	foreach (keys %{ $bagsHoldingColor{$color} }) {
		++$containers{$_};
		foreach (keys %{findContainers($_)}) {
			++$containers{$_};
		}
	}
	return \%containers;
}

while (<>) {
	chomp;
	# Parse each line such that the "key" bag goes into %input as a key
	# and the contained bags are elements of a list in the "value"
	my ($container, $containees) = /^(.*) bags contain (.*)\.$/;
	$containees =~ s/ bag[s]?[\.]?//g;
	$containees =~ s/, /,/g;
	#print "Key: $container\nValues: $containees\n\n";
	my @containees = split(',', $containees);
	foreach (@containees) {
		next if /no other/;

		my ($num, $color) =  /(\d*) (.*)/;
		$bagsHoldingColor{$color}{$container} = $num;
	}
};

# Print out struct to test
#foreach my $color (keys %bagsHoldingColor) {
#	print "$color contained by:\n";
#	foreach my $containingColor (keys %{ $bagsHoldingColor{$color} }) {
#		print "  $containingColor, $bagsHoldingColor{$color}{$containingColor}\n";
#	}
#}

my $answer = (keys %{findContainers($target)});

print "$answer\n";

