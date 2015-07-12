#!/usr/bin/perl -w

use strict;
use utf8;
use Test::More tests => 175;

use lib '../';
use ACDwide::DB;
use ACDwide::Config;
use ACDwide::Statuses qw{ $STATUS };

my $builder = Test::More->builder;
binmode $builder->output,         ":utf8";

### Config load and check section+
require_ok( 'ACDwide::Config' );
my $conf = new ACDwide::Config( '/etc/ACDwide/main.conf' );

isa_ok( $conf, 'ACDwide::Config' );
ok( !grep( { !$conf->{ 'base_'.$_ } } qw{ host port name login password } ), 
        'Database host, port, name, login and password are defined' );
### Config load and check section-

require_ok( 'ACDwide::DB' );

my $db = new ACDwide::DB( $conf );

can_ok( $db, ( 'ip_by_sip', ) );

### +Check and fill tables
# List of tables with tests data
my $tables = {
    'Manager'   => { name => 'Manager1' },
    'Operator'  => { name => 'Operator1', password => '123321', can_outgoing => 1 },
    'Service'   => { name => 'Service1', weight => 50 },
    'Location'  => { name => 'SIP/0000',  ip => '123.123.123.123' },
    'AgentsLog' => { agent => 1, event => 2, },
    'Call'      => { id => 1, agent => 1, status => 2 },
    'CallsRule' => { type => 'white', number => 111, text => 'goodwhite' },
    'Language'  => { name => 'Language1', name_short => 'ln' },
    'OperatorsLanguage' => { operator_id => 1, lang_id => 1 },
    'OperatorsService'  => { service_id => 1, operator_id => 1, weigth => 100 },
    'OperatorWorking'   => { operator_id => 1, number => 100, location=>'SIP/0009', 'status' => 10 },
    'Queue'     => { service_id => 1 },
    'Record'    => { file_name => 'File1' },
};

my $ids;
sub check_table {
    my ( $schema, $table, $params ) = @_;
    my $handler = $db->{_handler}->resultset( $table );
    my $r = $handler->create( $params );
    isa_ok( $r, $schema . '::' . $table );
    ok( $ids->{ $table } = $r->id, $table . ' : New record was inserted with id '. $r->id );
    ok( $ids->{ $table }, $table . ' : Record was found in table' );
}

sub clear_table {
    my ( $schema, $table, $params ) = @_;
    my $handler = $db->{_handler}->resultset( $table );
    ok( $handler->search( $params )->delete > 0, $table . ' : Record was deleted' );
}

$db->{_handler}->resultset( 'OperatorWorking' )->delete;

while( my( $table, $params ) = each %$tables ) {
    check_table( 'ACDwide::DB::Schema::Result', $table, $params );
}

$db->{_handler}->resultset( 'OperatorWorking' )->search( $tables->{'OperatorWorking'} )
              ->update( { operator_id => $ids->{Operator} } );
$tables->{'OperatorWorking'}{operator_id} = $ids->{Operator};

### -Check and fill tables


ok(  $db->ip_by_sip( 'SIP/0000' ) eq '123.123.123.123', 'SIP/0000 is on 123.123.123.123' );
ok( !$db->ip_by_sip( 'SIP/0001' ), 'SIP/0001 is not found in table' );

ok(  $db->sip_by_ip( '123.123.123.123' ) eq 'SIP/0000', '123.123.123.123 serve SIP/0000' );
ok( !$db->sip_by_ip( '123.123.123.124' ), '123.123.123.124 is not found in table' );

ok(  $db->operator_id_by_password( '123321' ) eq $ids->{Operator}, 'Operator 123321 found' );
ok( !$db->operator_id_by_password( '123322' ), 'Operator 123322 not found' );

ok(  $db->operator_values( $ids->{Operator} )->{number} eq '100', 'Operator_id '. $ids->{Operator} .' has number 100' );
ok( !$db->operator_values( $ids->{Operator}+1 )->{number}, 'Operator_id+1 has no number' );

ok(  $db->operator_name_by_id( $ids->{Operator} ) eq 'Operator1', 'Operator_id '. $ids->{Operator} .' is Operator1' );
ok( !$db->operator_name_by_id( $ids->{Operator}+1 ), 'Operator_id+1 is not exists' );

ok(  $db->operator_id_by_channel( 'SIP/0009' ) eq $ids->{Operator}, 'SIP/0009 is registred to Operator_id '. $ids->{Operator} );
ok( !$db->operator_id_by_channel( 'SIP/0001' ), 'SIP/0001 is unregistred' );

ok(  $db->operator_id_by_channel( '%/0009', 'like' ) eq $ids->{Operator}, 'like %/0009 is registred to Operator_id '. $ids->{Operator} );
ok( !$db->operator_id_by_channel( '%/0001', 'like' ), 'like %/0001 is unregistred' );

ok(  $db->channel_by_operator_id( $ids->{Operator} ) eq 'SIP/0009', 'Operator_id '. $ids->{Operator} .' is under SIP/0009' );
ok( !$db->channel_by_operator_id( $ids->{Operator}+1 ), 'Operator_id+1 is unregistred' );

ok(  $db->operator_is_login( $ids->{Operator} ) eq 10, 'Operator_id '. $ids->{Operator} .' is in status 10' );
ok( !$db->operator_is_login( $ids->{Operator}+1 ), 'Operator_id+1 is unregistred' );

ok(  $db->operator_can_outgoing_calls( $ids->{Operator} ), 'Operator_id '. $ids->{Operator} .' is can ougoing' );
ok( !$db->operator_can_outgoing_calls( $ids->{Operator}+1 ), 'Operator_id+1 is not found' );

$db->operator_events( $ids->{Operator}, 51 );
ok(  $db->{_handler}->resultset( 'AgentsLog' )->search( { agent => $ids->{Operator}, event => 51 } )->first->event == 51 , 'Operator_id '. $ids->{Operator} .' has event 51' );
$db->operator_events( $ids->{Operator}, 10, { callerid => 123 } );
ok(  $db->{_handler}->resultset( 'AgentsLog' )->search( { agent => $ids->{Operator}, event => 10 } )->first->callerid == 123 , 'Operator_id '. $ids->{Operator} .' has event 10 with callerid 123' );
$db->{_handler}->resultset( 'AgentsLog' )->search( { agent => $ids->{Operator} } )->delete;
ok( !$db->{_handler}->resultset( 'AgentsLog' )->search( { agent => $ids->{Operator} } )->first , 'Operator_id '. $ids->{Operator} .' has no events' );

$db->{_handler}->resultset( 'OperatorWorking' )->search( { operator_id => $ids->{Operator} } )->delete;
ok( !$db->operator_logout( $ids->{Operator} ), 'Operator_id '. $ids->{Operator} .' is not logged in' );
ok( !$db->operator_login( $ids->{Operator} ), 'Operator_id '. $ids->{Operator} .' try to login without location' );
ok( !$db->operator_login( $ids->{Operator}+1, 'SIP/0000' ), 'Operator_id+1 cannot login cause of he is not exists' );
ok(  $db->operator_login( $ids->{Operator}, 'SIP/0000' ), 'Operator_id '. $ids->{Operator} .' loged in' );
ok(  $db->{_handler}->resultset( 'AgentsLog' )->search( { agent => $ids->{Operator}, event => $STATUS->{login_event} } )->first , 'Operator_id '. $ids->{Operator} .' has logged in log record' );
ok(  $db->operator_is_login( $ids->{Operator} ) eq $STATUS->{free}, 'Operator_id '. $ids->{Operator} .' logged and has free status' );
ok(  $db->operator_logout( $ids->{Operator} ), 'Operator_id '. $ids->{Operator} .' is logged out' );
ok(  $db->{_handler}->resultset( 'AgentsLog' )->search( { agent => $ids->{Operator}, event => $STATUS->{logout_event} } )->first , 'Operator_id '. $ids->{Operator} .' has logged out log record' );
ok( !$db->operator_is_login( $ids->{Operator} ) , 'Operator_id '. $ids->{Operator} .' is not logged already' );

ok( !$db->operator_login( $ids->{Operator}+1, 'SIP/0000' ), 'Operator_id+1 cannot login cause of he is not exists' );
ok( !$db->operator_logout( $ids->{Operator}+1 ), 'Operator_id+1 is not logged in' );

$db->operator_login( $ids->{Operator}, 'SIP/0000' );
ok(  $db->operator_status( $ids->{Operator} ) == 1, 'Operator_id '. $ids->{Operator} .' status is 1' );
ok(  $db->operator_status( $ids->{Operator}, 4 ), 'Operator_id '. $ids->{Operator} .' try to change status to 4' );
ok(  $db->operator_status( $ids->{Operator} ) == 4, 'Operator_id '. $ids->{Operator} .' changed status to 4' );
ok(  $db->operator_status( $ids->{Operator}, 'busy' ), 'Operator_id '. $ids->{Operator} .' try to change status to busy' );
ok(  $db->operator_status( $ids->{Operator} ) == $STATUS->{busy}, 'Operator_id '. $ids->{Operator} .' changed status to busy' );
ok(  $db->operator_status( $ids->{Operator}, 'free' ), 'Operator_id '. $ids->{Operator} .' try to change status to free' );
ok(  $db->operator_status( $ids->{Operator} ) == $STATUS->{free}, 'Operator_id '. $ids->{Operator} .' changed status to free' );

ok( !$db->operator_status( $ids->{Operator}+1 ), 'Operator_id+1 try to get status' );
ok( !$db->operator_status( $ids->{Operator}+1, 4 ), 'Operator_id+1 try to change status to 4' );

ok(  $db->operator_status_set_busy( $ids->{Operator} ), 'Operator_id '. $ids->{Operator} .' try to set busy' );
ok(  $db->operator_status( $ids->{Operator} ) == $STATUS->{busy}, 'Operator_id '. $ids->{Operator} .' changed status to busy' );
ok( !$db->operator_status_set_busy( $ids->{Operator} ), 'Operator_id '. $ids->{Operator} .' try to set busy from busy' );
ok(  $db->operator_status( $ids->{Operator} ) == $STATUS->{busy}, 'Operator_id '. $ids->{Operator} .' is still busy' );
ok(  $db->operator_status( $ids->{Operator}, 'ringing' ), 'Operator_id '. $ids->{Operator} .' try to change status to ringing' );
ok(  $db->operator_status( $ids->{Operator} ) == $STATUS->{ringing}, 'Operator_id '. $ids->{Operator} .' changed status to ringing' );
ok(  $db->operator_status_set_busy( $ids->{Operator} ), 'Operator_id '. $ids->{Operator} .' try to set busy' );
ok(  $db->operator_status( $ids->{Operator} ) == $STATUS->{busy}, 'Operator_id '. $ids->{Operator} .' changed status to busy' );
ok(  $db->operator_status_set_free( $ids->{Operator} ), 'Operator_id '. $ids->{Operator} .' try to set free' );
ok(  $db->operator_status( $ids->{Operator} ) == $STATUS->{free}, 'Operator_id '. $ids->{Operator} .' changed status to free' );

ok(  $db->operator_status_set_ringing( $ids->{Operator} ), 'Operator_id '. $ids->{Operator} .' try to set ringing' );
ok(  $db->operator_status( $ids->{Operator} ) == $STATUS->{ringing}, 'Operator_id '. $ids->{Operator} .' changed status to ringing' );
ok(  $db->operator_status_set_busy( $ids->{Operator} ), 'Operator_id '. $ids->{Operator} .' try to set busy' );
ok(  $db->operator_status( $ids->{Operator} ) == $STATUS->{busy}, 'Operator_id '. $ids->{Operator} .' changed status to busy' );
ok(  $db->operator_status_set_ringing( $ids->{Operator} ), 'Operator_id '. $ids->{Operator} .' try to set ringing' );
ok(  $db->operator_status( $ids->{Operator} ) == $STATUS->{free}, 'Operator_id '. $ids->{Operator} .' changed status to free' );

ok(  $db->operators_online_all == 1, 'One operator is online' );
ok(  $db->operators_busy == 0, 'No one is busy' );
$db->operator_status_set_busy( $ids->{Operator} );
ok(  $db->operators_busy == 1, 'One is busy' );
$db->operator_status_set_free( $ids->{Operator} );
ok(  $db->operators_busy == 0, 'No one is busy' );
$db->operator_logout( $ids->{Operator} );
ok(  $db->operators_online_all == 0, 'No operators online' );
ok(  $db->operators_busy == 0, 'No one is busy' );
$db->operator_login( $ids->{Operator}, 'SIP/0000' );

ok(  $db->operators_busy == 0, 'No one is busy before add time' );
ok(  $db->operator_login_addtime( $ids->{Operator}, 3 ), 'Add time to wait' );
ok(  $db->operators_busy == 1, 'One is busy after add time' );
ok(  $db->operator_values( $ids->{Operator} )->{calls} == 0, 'No calls' );
ok(  $db->operator_values( $ids->{Operator} )->{calls_time} == 0, 'No spent time_calls' );
ok(  $db->operator_login_add_timecall( $ids->{Operator}, 10 ), 'Add one call, duration 10 sec' );
ok(  $db->operator_values( $ids->{Operator} )->{calls} == 1, 'Added one call' );
ok(  $db->operator_values( $ids->{Operator} )->{calls_time} == 10, 'Incrase on 10 sec call_time' );
ok(  $db->operators_busy == 1, 'Still busy after add timecall' );

ok(  $db->operator_password_by_id( $ids->{Operator} ) == 123321, 'Password correct' );
ok( !$db->operator_password_by_id( $ids->{Operator}+1 ), 'No Operator_id+1' );

ok(  $db->get_service_by_service_name( $tables->{Service}{name} )->{weight} eq $tables->{Service}{weight}, 'Get service weigth by name' );
ok( !$db->get_service_by_service_name( 'NoServiceName' )->{weight}, 'Service not found' );

ok(  $db->message_by_service_id( 2  ), 'Got message by service id' );
ok( !$db->message_by_service_id( -1 ), 'Message by service id not found' );

ok(  $db->message_white_list( $tables->{CallsRule}{number} ) eq $tables->{CallsRule}{text}, 'Get whitelist text' );
ok( !$db->message_white_list( $tables->{CallsRule}{number}.'1' ), 'No whitelist text for unknown' );
ok(  $db->check_white_list( $tables->{CallsRule}{number} ), 'Whitelist calls' );
ok(  $db->check_white_list( $tables->{CallsRule}{number} ), 'Whitelist calls again' );
ok(  $db->{_handler}->resultset( 'CallsRule' )->search( { number => $tables->{CallsRule}{number}, type => 'white' } )
        ->first->count == 2 , 'Total 2 whitelist calls' );
ok( !$db->check_white_list( $tables->{CallsRule}{number}.'1' ), 'Whitelist has no unknown number' );
ok( !$db->check_black_list( $tables->{CallsRule}{number} ), 'Blacklist has no white number' );

my $service_id = $ids->{Service};#$db->get_service_by_service_name( $tables->{Service}{name} )->{id};
ok(  $db->service_by_service_id( $service_id ) eq $tables->{Service}{name}, 'Get service name by id' );
ok( !$db->service_by_service_id( $service_id+1 ), 'Service name by id+1 not found' );

ok(  $db->client_queue_total( $service_id ) == 0, 'Queue has no members on service_id '.$service_id );
ok(  $db->client_queue_add( { service_id => $service_id, weight => 50 } )->id =~ /^(\d+)$/, 'Insert into queue' );
my $queue_id = $1;
ok(  $db->client_queue_total( $service_id ) == 1, 'Queue has 1 member on service_id '.$service_id );
ok(  $db->client_queue_place( $queue_id, $service_id ) == 1, 'Queue has 1 member on place' );
ok(  $db->client_queue_place( $queue_id+1, $service_id ) == 1, 'Queue has 1 member on place+1' );
ok(  $db->client_queue_place( $queue_id-1, $service_id ) == 0, 'Queue no members on place-1' );
ok(  $db->client_queue_busy( $queue_id, 1 ), 'Queue '.$queue_id.' is set to busy' );
ok(  $db->client_queue_total( $service_id ) == 0, 'Queue has no members on service_id '.$service_id );
ok(  $db->client_queue_busy( $queue_id, 0 ), 'Queue '.$queue_id.' is set to free' );
ok(  $db->client_queue_total( $service_id ) == 1, 'Queue has 1 member on service_id '.$service_id );

my $services_list;
ok(  $db->add_service_to_operator( $ids->{Service}, $ids->{Operator}, 50 ), 'Add service '. $ids->{Service} .' to operator '. $ids->{Operator} );
ok(  $services_list = $db->get_services_by_operator_id( $ids->{Operator} ), 'Get services of operator '. $ids->{Operator} );
ok(  @{$services_list} == 1, 'One service on operator' );
ok(  $services_list->[0]{name} eq 'Service1', 'First service is Service1' );
ok(  $db->add_service_to_operator( $ids->{Service}, $ids->{Operator}, 50 ), 'Add service '. $ids->{Service} .' to operator '. $ids->{Operator} .' again' );
ok(  $services_list = $db->get_services_by_operator_id( $ids->{Operator} ), 'Get services of operator '. $ids->{Operator} );
ok(  @{$services_list} == 2, 'Two services on operator' );

ok(  $db->client_queue_next->[0], 'Found all next clients in queue' );
ok(  $db->client_queue_next->[0]->min == $queue_id, 'First next client has queue_id '. $queue_id );

$db->{_handler}->resultset( 'OperatorWorking' )->search( { operator_id => $ids->{Operator} } )->update( { timestamp => time()-1 } );
my $operators_online = $db->operators_free_online( $ids->{Service} );
ok(  $operators_online->[0], 'Found free online operator for service '.$ids->{Service} );
ok(  $operators_online->[0]->operator_id == $ids->{Operator}, 'Free online operator is '.$ids->{Operator} );
ok( !$db->operators_free_online( $ids->{Service} )->[0], 'Not found any free online operator for service '.$ids->{Service} );

ok(  $services_list->[1]{name} eq 'Service1', 'Second service is Service1' );
ok( !$db->get_services_by_operator_id( $ids->{Operator}+1 )->[0], 'No services of operator_id+1' );
ok(  $db->remove_service_from_operator( $ids->{Service}, $ids->{Operator} ), 'Remove service '. $ids->{Service} .' from operator '. $ids->{Operator} );
ok( !$db->get_services_by_operator_id( $ids->{Operator} )->[0], 'No services of operator_id' );

ok(  $db->client_queue_remove( $queue_id ), 'Queue '.$queue_id.' removed' );
ok(  $db->client_queue_total( $service_id ) == 0, 'Queue has no members on service_id '.$service_id );

### +Clear tables
$db->operator_logout( $ids->{Operator} );
$db->{_handler}->resultset( 'OperatorWorking' )->create( $tables->{'OperatorWorking'} );
while( my( $table, $params ) = each %$tables ) {
    clear_table( 'ACDwide::DB::Schema::Result', $table, $params );
}
ok(  $db->{_handler}->resultset( 'AgentsLog' )->search( { agent => { '>=', $ids->{Operator} } } )->delete, 'Logs cleared for operator_id more than '.$ids->{Operator} );
#use Data::Dump qw(dump dd ddx); local *Data::Dump::quote = sub { return qq("$_[0]"); }; print ddx $tables; die;
### -Clear tables
