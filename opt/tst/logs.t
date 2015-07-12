#!/usr/bin/perl -w

use strict;
use utf8;
use Test::More tests => 18;

use lib '../';
use ACDwide::Logs;
use ACDwide::Config;

my @log_name = qw{ log callers_dump };

my $builder = Test::More->builder;
binmode $builder->output,         ":utf8";

### Config load and check section+
require_ok( 'ACDwide::Config' );
my $conf = new ACDwide::Config( '/etc/ACDwide/main.conf' );
$conf->{ 'files_test_tmp' } = '/tmp/acdwide.log';

isa_ok( $conf, 'ACDwide::Config' );

ok( !grep( { !$conf->{ 'files_'.$_ } } @log_name ), 'Logs files are defined in config' );
### Config load and check section-

foreach ( @log_name ) {
    next unless $conf->{ 'files_'.$_ } =~ /(.+)\//;
    ok( -d $1, "folder $1 exists" );
}

require_ok( 'ACDwide::Logs' );

my $log = new ACDwide::Logs( $conf );

ok( $log->{test_tmp}->debug("Debug message"), "Log debug message" );
$_ = `cat $conf->{ 'files_test_tmp' }`;
ok( /ACDwide.test_tmp - Debug message/, "Saved debug message" );

ok( $log->{test_tmp}->info("Info message"), "Log info message" );
$_ = `cat $conf->{ 'files_test_tmp' }`;
ok( /ACDwide.test_tmp - Info message/, "Saved info message" );

ok( $log->{test_tmp}->error("Error message"), "Log error message" );
$_ = `cat $conf->{ 'files_test_tmp' }`;
ok( /ACDwide.test_tmp - Error message/, "Saved error message" );

ok( $log->debug("Debug message 2", "test_tmp"), "Log second debug message" );
$_ = `cat $conf->{ 'files_test_tmp' }`;
ok( /ACDwide.test_tmp - Debug message 2/, "Saved second debug message" );

ok( $log->uniqueid( 123 ) eq 123, "Set unique id" );
ok( $log->uniqueid eq 123, "unique id is 123" );

ok( $log->debug("Debug message", "test_tmp"), "Log debug message with id" );
$_ = `cat $conf->{ 'files_test_tmp' }`;
ok( /ACDwide.test_tmp - \[123\] Debug message/, "Saved debug message with id" );

unlink $conf->{ 'files_test_tmp' };
