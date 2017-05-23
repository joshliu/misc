use strict;
use warnings;
use Math::Round;
use YAML::XS 'LoadFile';


# Created for DuckDuckGo by Joshua Liu

# Masses taken from http://www.csudh.edu/oliver/chemdata/atmass.htm, superheavy 
#       elements added manually with alternate names

my %masses = %{LoadFile('elements.yml')};
# my %compounds = %{ LoadFile('compounds.yml') };

# returns true if input only comprised of numbers
sub is_int {
    my ($val) = @_;
    return ($val =~ m/^\d+$/);
}

# returns true if input only comprised of letters
sub is_compound {
    my ($cmp) = @_;
    return ($cmp =~ /^([a-z]|[A-Z])+$/);
}

# sanatize verifies that the input is suitable for processing.
# Sanatization Strategy:
#   - Check that formula is only comprised of alphanumerics and parentheses.
#   - Check number of right parens never exceeds number of left parens
#   - Check each number preceded by a letter or right parentheses.
#   - Check each lowercase char preceded by another lowercase char or an uppercase char.
# Returns -1 if any of these checks fail.
sub sanatize {
    my ($string) = @_;
    
    if (!($string =~ /^([a-z]|[A-Z]|[0-9]|["("]|[")"])+$/)) {
        return -1;
    }

    my $paren_count = 0;
    for my $c (split //, $string) {
        if ($c eq "(") {
            $paren_count += 1;
        } elsif ($c eq ")") {
            $paren_count -= 1;
        }
        if ($paren_count < 0) {
            return -1;
        }
    }

    my $prev = "NULL";
    for my $c2 (split //, $string) {
        if ($c2 =~ /[a-z]/ 
            && (!(is_compound($prev)) || ($prev eq "NULL"))) {
            return -1;
        } elsif (is_int($c2) 
            && !((is_compound($prev) && !($prev eq "NULL")) || $prev eq ")")) {
            return -1;
        }
        $prev = $c2;
    }

    return 0;
}

# verify_compounds verifies that every compound in the array is in the 
#   table of masses, returns -1 otherwise.
sub verify_compounds {
    my @arr = @{$_[0]};
    my $arr_len = scalar(@arr);
    for my $i (0..$arr_len - 1) {
        if (ref($arr[$i]) eq 'ARRAY') {
            return -1 if (verify_compounds($arr[$i]) == -1);
        } elsif (is_compound($arr[$i])) {
            return -1 if !(exists $masses{$arr[$i]});
        }
    }
    return 0;
}

# parse turns a string such as "Al2(SO4)3" into a nested array that looks
#   like ["Al",2,["S","O",4],3].
sub parse {
    my ($string) = @_;
    my @stack = [];
    my @a = [];
    push @stack, @a;
    for my $c (split //, $string) {
        if ($c eq '(') {
            my @arr = [];
            push @stack, @arr;
        } elsif ($c eq ')') {
            my $temp = pop @stack;
            push $stack[-1], $temp;
        } elsif (is_int($c)) {
            if (is_int($stack[-1][-1])) {
                # joins integer digits together if 
                #   $c is a digit of a larger integer
                $stack[-1][-1] = $stack[-1][-1] * 10 + $c;
            } else {
                push $stack[-1], $c;
            }
        } elsif ($c =~ /[a-z]/) {
            # joins lowercase letters to the last character before it
            # will not fail as long as input is sanitized.
            $stack[-1][-1] = $stack[-1][-1] . $c;
        } else {
            # this should be reached by capitalized characters
            push $stack[-1], $c;
        }
    }
    return $stack[-1];
}

# calc_mass calculates the molar mass of a nested array produced by parse.
sub calc_mass {
    my @arr = @{$_[0]};
    my $arr_len = scalar(@arr);
    my $mass = 0;
    for my $i (0..$arr_len - 1) {
        # Pseudocode:
        # First, check if $i is the last index of the array, because the rest
        #   of the algorithm depends on being able to check the i+1 th element.
        # 3 cases for the ith element: 
        #   1. it is a standalone element represented by a string
        #   2. it is a multi-element molecule that is represented by an array
        #   3. it is an integer, but we will handle integers in cases 1 and 2 
        #       so we can ignore $i if it is an integer.
        #  For cases 1 and 2, we need to check if the i+1th element is an 
        #       integer, if it is, we multiply by the i+1th integer

        if ($i == $arr_len - 1) {
            # Special handler for last index.
            $mass = $mass + calc_mass($arr[$i]) if ref($arr[$i]) eq 'ARRAY';
            $mass = $mass + $masses{$arr[$i]} if exists $masses{$arr[$i]}
        } elsif (ref($arr[$i]) eq 'ARRAY' && is_int($arr[$i+1])) {
            $mass += calc_mass($arr[$i]) * $arr[$i+1];
        } elsif (ref($arr[$i]) eq 'ARRAY') {
            $mass += calc_mass($arr[$i]);
        } elsif (is_compound($arr[$i]) && is_int($arr[$i+1])) {
            $mass += $masses{$arr[$i]}*$arr[$i+1] if exists $masses{$arr[$i]};
        } elsif (exists $masses{$arr[$i]}) {
            $mass += $masses{$arr[$i]};
        } # Other cases are ignored.
    }
    return $mass;
}

# returns the molar mass of the string passed to it
# returns -1 if some mass is not found, or if there is invalid input
sub molar_mass {
    # Note: sanatize and verify_compounds return -1 if given invalid input.
    my ($str) = @_;
    my $sanatize_result = sanatize($str);
    return -1 if ($sanatize_result == -1);
    my @temp_arr = parse($str);
    my $verified_result = verify_compounds(@temp_arr);
    return -1 if ($verified_result == -1);
    return nearest(0.0001, calc_mass(@temp_arr));
}

print molar_mass("H2O");

1;
