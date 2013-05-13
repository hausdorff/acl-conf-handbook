#! /usr/bin/perl

## @author: Baskaran Sankaran (May 2012) for NAACL-12 handbook

## Reads an event program file (in tex) and inserts the \index command for the author names for each page
## Assumes that each page is formatted as tabular and inserts the indices after 'tabular' envorinment

# Input : tex file for which the indices need to be created as STDIN
# Output: tex file with the indices to STDOUT

use strict;

my $verbose = 0; # Turn it on for debugging

my $auth_name;
my $last_name;
my $first_names;
my @authors = ();
my @indxArr = ();
my %uniqAuthHsh = ();

while(<STDIN>) {
    chomp;
    print "$_\n";
    if ( /\\textit{(.*)}\s*\\\\\s*$/ ) {
        @authors = split(/,\s*|\s+and\s+/, $1);
        if ($verbose) {
            print STDERR "\n --------------- \n";
            print STDERR "$1\n";
        }
        foreach (@authors) {
            if ($verbose) { print STDERR "  ** $_  ::"; }
            s/^\s*|\s*$//;
            s/^(.+)\s(\S+)$//;

            $first_names = $1;
            $last_name = $2;
            $first_names =~ s/\s(\w\.)/\~$1/g;
            $auth_name = $last_name . ", " . $first_names;

            # Trim multiple/trailing spaces in the author name
            $auth_name =~ s/^\s*|\s*$//;
            $auth_name =~ s/\s+/ /;
            if ($verbose) { print STDERR "  $auth_name\n"; }
            if (!exists $uniqAuthHsh{$auth_name}) {
                $uniqAuthHsh{$auth_name} = 1;
                push @indxArr, $auth_name;
            }
        }
        next;
    }

    if ( /^\\end{tabular}/ ) {
        foreach (@indxArr) {
            print "\\index{$_}\n";
        }
        @indxArr = ();
        %uniqAuthHsh = ();
    }
}

