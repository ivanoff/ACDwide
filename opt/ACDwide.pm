package ACDwide;
use strict;
use base 'Asterisk::FastAGI';

our $conf = _read_config("callcenter.conf");

### DEFAULT SETTINGS
$conf->{'files.log'} ||= 'callcenter.log';
$conf->{'files.pid'} ||= 'callcenter.pid';

# WRITE PID
open my $pidfile, '>', $conf->{'files.pid'};
print $pidfile $$;
close $pidfile;
_addlog( "ACDwide was started. PID[$$]" );

sub _read_config {
    my $conf->{'_filename'} = shift;
    my $section;
    open my $configfile, '<', $conf->{'_filename'} or return $conf;
    foreach ( <$configfile> ) {
        $section = $1 if /^\[(.*)\]/;
        next unless /^[\ \t]*([^=\ \t\[]+)[\ \t]*=[\ \t]*(.*)[\ \t]*/;
        my ( $conf_name, $conf_val ) = ( $1, $2 );
        $conf_name = "$section.$conf_name" if $section;
        $conf->{$conf_name} = $conf_val;
    }
    close $configfile;
    return $conf;
}

sub login {
    my $self = shift;
    print("!? login ");
}

1;
