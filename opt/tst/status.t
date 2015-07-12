#!/usr/bin/perl -w

use strict;
use utf8;
use Test::More tests => 10;

use lib '../';
use ACDwide::Statuses qw{ $STATUS };

my $builder = Test::More->builder;
binmode $builder->output,         ":utf8";

require_ok( 'ACDwide::Statuses' );

ok( $STATUS, 'statuses is defined' );

ok( $STATUS->{ locked } == 0, 'locked status is defined' );
ok( $STATUS->{ free },        'free status is defined' );
ok( $STATUS->{ busy },        'busy status is defined' );
ok( $STATUS->{ ringing },     'ringing status is defined' );

ok( $STATUS->{ login_event  }, 'login event status is defined' );
ok( $STATUS->{ logout_event }, 'logout event status is defined' );

ok( $STATUS->{ local_outgoing }, 'local outgoing event status is defined' );
ok( $STATUS->{ local_incoming }, 'local incoming event status is defined' );

