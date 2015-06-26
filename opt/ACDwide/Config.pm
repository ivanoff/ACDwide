package ACDwide::Config;

use utf8;

sub new {
    my ( $class, $filename ) = @_;
    my $self = {};
    bless $self, ref $class || $class;

    if ( ! -e $filename && $self =~ /^(\w+)/ ) {
        $filename = 
              ( -e "$1.conf"      )? "$1.conf"
            : ( -e "/etc/$1.conf" )? "/etc/$1.conf"
            : '';
    }
    $self->read_config( $filename ) if -e $filename;

    return $self;
}

sub read_config {
    my ( $self, $config_filename ) = @_;
    my $section = '';
    open my $configfile, '<', $config_filename or return 0;
    foreach ( <$configfile> ) {
        $section = $1.'_' if /^\[(.*)\]/;
        next unless /^[\ \t]*([^=\ \t\[]+)[\ \t]*=[\ \t]*(.*)[\ \t]*/;
        $self->{$section.$1} = $2;
    }
    close $configfile;
}

1;