use strict;
use warnings;
use 5.008002;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'ISBN::Country',
    license             => 'perl',
    dist_author         => q{Moritz Lenz <moritz@faui2k3.org>},
    dist_version_from   => 'lib/ISBN/Country.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires    => {
        perl        => '5.008002',
    },
    add_to_cleanup      => [ 'ISBN-Country-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
