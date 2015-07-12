package ACDwide::Errors;

use Exporter;
our @ISA        = qw( Exporter );
our @EXPORT_OK  = qw( $ERROR   );

our $ERROR = 
{

## incomings
    2011 => 'Incoming number is in blacklist',
    2031 => 'Queue maximum limit reached',
    
## operators
    3011 => 'Operator entered a wrong password',
    3012 => 'Operator is trying to log out but he has not logged in yet',

    3021 => 'Operator can\'t make outgoing calls',
    3022 => 'Operator calls to busy operator',
};