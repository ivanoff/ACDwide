#!/usr/bin/perl -w

use strict;
use utf8;
use Test::More tests => 9;

use lib '../';
use ACDwide::Config;

my $builder = Test::More->builder;
binmode $builder->output,         ":utf8";

require_ok( 'ACDwide::Config' );

my $conf = new ACDwide::Config( '/etc/ACDwide/main.conf' );

isa_ok( $conf, 'ACDwide::Config' );
can_ok( $conf, ( 'read_config', ) );

ok( !grep( { !$conf->{ 'base_'.$_ } } qw{ host port name login password } ), 
        'Database host, port, name, login and password are defined' );

ok( $conf->{ files_log }, 'log filename is defined' );

ok( $conf->{ files_callers_dump }, 'callers dump filename is defined' );

ok( $conf->{ langs }, 'languages is defined' );


$conf = new ACDwide::Config( '/etc/ACDwide/asterisk.conf' );

isa_ok( $conf, 'ACDwide::Config' );

ok( $conf->{ pid }, 'PID filename is defined' );

