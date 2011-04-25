use Test::More tests => 6;
use lib qw/blib lib/;
use ISBN::Country qw/isbn_extract/;
use strict;
use warnings;

my $h = isbn_extract('0345518705');
is $h->{lang}[0], 'en', 'found English';
like join(',', @{$h->{countries}}), qr/us/, 'and the US is among the countries';

$h = isbn_extract('0-345-51870-5');
is $h->{lang}[0], 'en', 'also works with dashes';

$h = isbn_extract('1588468178');
is $h->{lang}[0], 'en', 'also works for secondary languages';

$h = isbn_extract('9780345518705');
is $h->{lang}[0], 'en', 'isbn-13 without dashes';

$h = isbn_extract('978-0-345-51870-5');
is $h->{lang}[0], 'en', 'isbn-13 with dashes';
