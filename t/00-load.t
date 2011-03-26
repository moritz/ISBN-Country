#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'ISBN::Country' ) || print "Bail out!
";
}

diag( "Testing ISBN::Country $ISBN::Country::VERSION, Perl $], $^X" );
