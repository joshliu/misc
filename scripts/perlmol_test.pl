use strict;
use warnings;
use Chemistry::Mol;
use Chemistry::Pattern;

my $mol = "Al2(SO4)3";
my @atoms = $mol->atoms;

print $atoms[0];

1;