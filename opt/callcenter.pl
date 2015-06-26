#!/usr/bin/perl

use strict;
use ACDwide;

my $pid = fork();
die "fork dont work: $!" if !$pid;

if ($pid) {
    my $config  = ACDwide::_read_config( 'callcenter.conf' );
    my $pidfile ||= 'callcenter.pid';
    open my $f, '>', $pidfile;
    print $f $$;
    close $f;

    ACDwide::_addlog( "ACDwide was started...");
    ACDwide->run( port => '4573', user=>'asterisk', group=>'asterisk' );
    waitpid $$, 0;
}
