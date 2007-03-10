#!perl

use warnings;
use strict;

use Test::More tests => 3;
use App::Ack ();
use File::Next ();

use lib 't';
use Util;


TYPES: {
    my $file = 't/etc/shebang.pl.xxx';
    my @types = App::Ack::filetypes( $file );
    is( scalar @types, 1, 'Only one type' );
    is( $types[0], 'perl', 'Type matches' );
}

ACK_F: {
    my @expected = qw(
        t/etc/shebang.empty.xxx
        t/swamp/moose-andy.jpg
    );

    my @files = qw( t );
    my @args = qw( -f --binary );
    my $cmd = "$^X ./ack-standalone @args @files";
    my @results = `$cmd`;
    chomp @results;

    sets_match( \@results, \@expected, 'Looking for binary' );
}