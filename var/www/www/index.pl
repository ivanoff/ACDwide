#!/usr/bin/perl

use strict;
use warnings;

use lib '../modules';
use Time::HiRes qw( gettimeofday tv_interval );
use SimplenessCMS::MAIN::Cache qw( cache_load cache_md5_filename );
use SimplenessCMS::MAIN::Update qw( update need_to_update );
use SimplenessCMS::CONFIG;

my $time_interval = [ gettimeofday() ];

eval {
    local $SIG{ALRM} = sub { die "alarm\n" };
    alarm 5*60;

    # get session parameters
    our $index_session;
    if ( $ENV{HTTP_COOKIE} && $ENV{HTTP_COOKIE} =~ /CGISESSID=([0-9a-f]{32})/ ) {
        $index_session = eval { local $SIG{__DIE__}; do $CONFIG->{session_dir}."/cgisess_$1"; };
    }

    if ( my $body = cache_load ) {
        # show page from cache
        print "Content-Type: text/html; charset=utf-8\nCache-Control: no-cache, must-revalidate\nExpires: Sat, 26 Jul 1997 05:00:00 GMT\n\n";
        print $body;
        print "\n<!-- ".(tv_interval($time_interval)*1000)." ms cache -->";
    } else {
        # main lifecycle
        eval { require 'main.pl' };
        print $@;
    }

#    update if $CONFIG->{update_automatically} && need_to_update;

    alarm 0;
};

if ($@) {
    print "Status: 408 Request Timeout\n\n";
}
