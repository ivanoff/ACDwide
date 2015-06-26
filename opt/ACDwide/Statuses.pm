package ACDwide::Statuses;

use Exporter;
our @ISA     = qw( Exporter );
our @EXPORT_OK  = qw( $STATUS );

our $STATUS = 
{
    free         => 1,
    ringing      => 3,
    busy         => 4,

    local_outgoing => 9,
    local_incoming => 8,
    
    login_event  => 51,
    logout_event => 52,
};