#!/usr/bin/perl

use warnings;
use strict;

my %containedBy;
my $target = pop;

sub findContents {
	my $color = shift;
	my $total = 0;
	foreach (keys %{ $containedBy{$color} }) {
		$total += $containedBy{$color}{$_} + $containedBy{$color}{$_} * findContents($_);
	}
	return $total;
}

while (<>) {
	chomp;
	my ($container, $containees) = /^(.*) bags contain (.*)\.$/;
	# Building the regex for what we're deleting from the $containees string
	## ' bag' matches " bag"
	## '[s]?' followed by 0 or 1 's'
	## '[\.]?' followed by 0 or 1 literal '.'
	# /g does the replacement for all occurences of the match (aka: globally) on the line
	$containees =~ s/ bag[s]?[\.]?//g;
	# Replace " ," with ","
	$containees =~ s/, /,/g;
	foreach (split(',', $containees)) {
		next if /no other/;

		my ($num, $containee) =  /(\d*) (.*)/;
		$containedBy{$container}{$containee} = $num;
	}
};

my $answer = findContents($target);

print "$answer\n";

