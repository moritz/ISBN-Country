package ISBN::Country;

use warnings;
use strict;

use Exporter qw/import/;

our @EXPORT_OK = qw/isbn_extract/;

=head1 NAME

ISBN::Country - Extract country and language information from ISBN

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.05';

# TODO: also import information from http://everything2.com/title/ISBN+Country+codes
#

our %Info;
%Info = (
    0   => {
        lang        => [qw/en/],
        countries   => [qw/us gb au/],
    },
    2   => {
        lang        => [qw/fr/],
        countries   => [qw/fr/],
    },
    3   => {
        lang        => [qw/de/],
        countries   => [qw/de at ch/],
    },
    4   => {
        lang        => [qw/ja/],
        countries   => [qw/jp/],
    },
    5   => {
        lang        => [qw/ru uk/],
        countries   => [qw/ru/],
    },
    600 => {
        lang        => [qw/fa/],
        countries   => [qw/ir/],
    },
    601 => {
        lang        => [qw/kk ru/],
        countries   => [qw/kz/],
    },
    7   => {
        lang        => [qw/zh/],
        countries   => [qw/cn tw/],
    },
    81   => {
        lang        => [qw/hi/],
        countries   => [qw/in/],
    },
    82  => {
        lang        => [qw/no/],
        countries   => [qw/nb nn/],
    },
    83  => {
        lang        => [qw/pl/],
        countries   => [qw/pl/],
    },
    84  => {
        lang        => [qw/es/],
        countries   => [qw/es/],
    },
    85  => {
        lang        => [qw/pt/],
        countries   => [qw/br/],
    },
    87  => {
        lang        => [qw/da/],
        countries   => [qw/dk/],
    },
    88  => {
        lang        => [qw/it/],
        countries   => [qw/it/],
    },
    89  => {
        lang        => [qw/ko/],
        countries   => [qw/kr/],
    },
    950 => {
        lang        => [qw/es/],
        countries   => [qw/ar/],
    },
    951 => {
        lang        => [qw/fi/],
        countries   => [qw/fi/],
    },
    953 => {
        lang        => [qw/hr/],
        countries   => [qw/hr/],

    },
    956 => {
        lang        => [qw/es/],
        countries   => [qw/cl qu/],
    },
    972 => {
        lang        => [qw/pt/],
        countries   => [qw/pt/],
    },
    974 => {
        lang        => [qw/th/],
        countries   => [qw/th/],
    },
    975 => {
        lang        => [qw/tr/],
        countries   => [qw/tr/],
    },
    957 => {
        lang        => [qw/zh/],
        countries   => [qw/tw/],
    },
    960 => {
        lang        => [qw/el/],
        countries   => [qw/gr/],
    },
    962 => {
        lang        => [qw/zh/],
        countries   => [qw/hk/],
    },
    963 => {
        lang        => [qw/hu/],
        countries   => [qw/hu/],
    },
    964 => {
        lang        => [qw/fa/],
        countries   => [qw/ir/],
    },
    965 => {
        lang        => [qw/he/],
        countries   => [qw/il/],
    },
    967 => {
        lang        => [qw/ms/],
        countries   => [qw/my/],
    },
    968 => {
        lang        => [qw/es/],
        countries   => [qw/mx/],
    },
    979 => {
        lang        => [qw/id/],
        countries   => [qw/id/],
    },
    981 => {
        lang        => [qw/en my zh ta/],
        countries   => [qw/sg/],
    },
    9946 => {
        lang        => [qw/ko/],
        countries   => [qw/kp/],
    },
    9976 => {
        lang        => [qw/sw en/],
        countries   => [qw/tz/],
    },
    9979 => {
        lang        => [qw/is/],
        countries   => [qw/is/],
    },
    99915 => {
        lang        => [qw/dv/],
        countries   => [qw/mv/],
    },
    99923 => {
        lang        => [qw/es qu/],
        countries   => [qw/ec/],
    },
    99929 => {
        lang        => [qw/mn/],
        countries   => [qw/mn/],
    },
    99929 => {
        lang        => [qw/zh pt/],
        countries   => [qw/mo/],
    },
    99929 => {
        lang        => [qw/zh pt/],
        countries   => [qw/mo/],
    },
    99951 => {
        lang        => [qw/fr kg ln/],
        countries   => [qw/kg/],
    },
    99953 => {
        lang        => [qw/es qu/],
        countries   => [qw/py/],
    },
);

our @Aliases = qw/
       1:0
      10:2
      93:81
     952:951
     970:968
     989:972
     986:957
     988:962
     987:967
    9971:981
    /;

for (@Aliases) {
    my ($to, $from) = split /:/;
    $Info{$to} = $Info{$from};
}

sub _build_re {
    my $re = join '|', sort { length($b) <=> length($a) } keys %Info;
    qr{$re};
}

our $InfoRe = _build_re;


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use ISBN::Country;

    my $foo = ISBN::Country->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 isbn_extract

    my $h = isbn_extract($isbn);

takes an ISBN-10 or ISB-13 and returns a hash reference. Returns a hash
reference describing likely countries and languages. Hash keys are
C<lang> and C<countries>. C<$h->{lang}> contains an array reference of
ISO 639-1 language codes. C<$h->{countries}> contains an array reference
of ISO-3166-1 country codes.

Both can be rather incomplete.

=cut

sub isbn_extract {
    my $isbn = shift;
    $isbn =~ tr/0-9X//cd;
    $isbn = substr($isbn, 3) if length($isbn) == 13;
    if ($isbn =~ /^($InfoRe)/) {
        return $Info{$1};
    } else {
        return;
    }
}


=head1 AUTHOR

Moritz Lenz, C<< <moritz at faui2k3.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-isbn-country at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=ISBN-Country>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc ISBN::Country


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=ISBN-Country>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/ISBN-Country>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/ISBN-Country>

=item * Search CPAN

L<http://search.cpan.org/dist/ISBN-Country/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Moritz Lenz.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of ISBN::Country
