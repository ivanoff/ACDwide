package ACDwide::DB;

use strict;
use warnings;
use ACDwide::DB::Schema;
use ACDwide::Statuses qw{ $STATUS };

sub new {
    my ( $class, $conf ) = @_;

    my $self = {
        _conf    => $conf,
        _handler => ACDwide::DB::Schema->connect(
            'dbi:Pg:dbname='.$conf->{base_name}.' host='.$conf->{base_host}.' port='.$conf->{base_port}, 
            $conf->{base_login}, $conf->{base_password}, {
                quote_names => 1,
                mysql_enable_utf8 => 1,
        })
    };

    bless $self, ref $class || $class;

    return $self;
}

# return the ip address of the computer with a SIP phone connected to
sub ip_by_sip {
    my ( $self, $sip ) = @_;
    my $res = $self->{_handler}->resultset( 'Location' )
                   ->search( { name => $sip } )->first;
    return $res? $res->ip : undef;
}

# SIP/phone number by the ip address of the computer
sub sip_by_ip {
    my ( $self, $ip ) = @_;
    my $res = $self->{_handler}->resultset( 'Location' )
                   ->search( { ip => $ip } )->first;
    return $res? $res->name : undef;
}

# return id of the operator by his/her password
sub operator_id_by_password {
    my ( $self, $password ) = @_;
    my $res = $self->{_handler}->resultset( 'Operator' )
                   ->search( { password => $password, date_fired => undef } )->first;
    return $res? $res->id : undef;
}

# return the name of the operator by his/her id
sub operator_name_by_id {
    my ( $self, $id ) = @_;
    my $res = $self->{_handler}->resultset( 'Operator' )
                   ->search( { id => $id } )->first;
    return $res? $res->name : undef;
}

# return operator values by operator's id
sub operator_values {
    my ( $self, $operator_id ) = @_;
    my $res = $self->{_handler}->resultset( 'OperatorWorking' )
                   ->search( { operator_id => $operator_id }, 
                             { columns => [qw{ number service_id channels location 
                                                status calls calls_time }] } );
    $res->result_class('DBIx::Class::ResultClass::HashRefInflator');
    return $res->first || {};
}

# status of the operator by id
sub operator_is_login {
    my ( $self, $operator_id ) = @_;
    return $self->operator_values( $operator_id )->{status};
}

# returns the name of the channel by operator id
sub channel_by_operator_id {
    my ( $self, $operator_id ) = @_;
    return $self->operator_values( $operator_id )->{location};
}

# returns id of the operator by name of the channel
sub operator_id_by_channel {
    my ( $self, $channel, $like ) = @_;
    $channel = { like => $channel } if $like;
    my $res = $self->{_handler}->resultset( 'OperatorWorking' )
              ->search( { location => $channel } )->first;
    return $res? $res->operator_id : undef;
}

# is operator can outgoing calls
sub operator_can_outgoing_calls {
    my ( $self, $id ) = @_;
    my $res = $self->{_handler}->resultset( 'Operator' )
              ->search( { id => $id } )->first;
    return $res? $res->can_outgoing : undef;
}

# Store operator's event to database
sub operator_events {
    my ( $self, $operator_id, $event, $p ) = @_;
    $p ||= {};
    map { delete $p->{$_} unless /^callerid|timer|acdgroup|extention|beforeanswer|dialstatus|begin_time|record_id$/ } keys %$p;

    if ( $p->{record_id} ) {
        my $record = $self->{_handler}->resultset( 'Record' )
                  ->search( { file_name => $p->{record_id} } )->first;
        $p->{record_id} = $record? $record->{record_id} : 0;
    }

    my $handler = $self->{_handler}->resultset( 'AgentsLog' )
                ->create( { agent => $operator_id, event => $event, %$p } );
}

#login operator by id
sub operator_logout {
    my ( $self, $operator_id ) = @_;
    my $res = $self->{_handler}->resultset( 'OperatorWorking' )
              ->search( { operator_id => $operator_id } )->delete;
    $self->operator_events( $operator_id, $STATUS->{logout_event} );
    return $res == 0? 0 : 1;
}

#logout operator by id and location
sub operator_login {
    my ( $self, $operator_id, $location ) = @_;
    return 0 unless $location;
    return 0 unless $self->{_handler}->resultset( 'Operator' )->search( { id => $operator_id } )->first;
    
    $self->operator_logout( $operator_id ) if $self->operator_is_login( $operator_id );

    my $res = $self->{_handler}->resultset( 'OperatorWorking' )
                ->create( { operator_id => $operator_id, time => \ 'NOW()', 
                            status => $STATUS->{free}, location => $location }, calls => 0, 
                            calls_time => 0, rate => 0, timestamp => \ 'NOW()' );

    $self->operator_events( $operator_id, $STATUS->{login_event} );
    return $res? 1 : 0;
}

# updating the status of the operator
sub operator_status {
    my ( $self, $operator_id, $status, $where, $p ) = @_;
    return 0 if !$operator_id;
    $p ||= {};
    $p->{time}      ||= \ 'time';
    $p->{timestamp} ||= \ 'timestamp';
    $where ||= {};
    $status = $STATUS->{ $status } if $status && $status =~ /\D/;
    my $handler = $self->{_handler}->resultset( 'OperatorWorking' )
                    ->search( { operator_id => $operator_id, %$where } );

    return $handler->first? $handler->first->status : undef unless $status;

    return int( $handler->update( { status => $status, %$p } ) );
}

# set status of the operator to busy by operator id
sub operator_status_set_busy {
    my ( $self, $operator_id, $p ) = @_;
    $p = { 
        time => \ 'NOW()', timestamp => time(), channels_check => 1,
        map { $_ => $p->{ $_ } } qw{ number service_id channels },
    };
#tolog(3, "ERROR: $p->{number} hanged up closely after connect")
#     if $self->operator_status( $operator_id ) == $STATUS->{ringing};

    return $self->operator_status( $operator_id, 'busy', 
                    { status => { -not_in=>[ $STATUS->{busy} ] } }, $p );
}

# set status of the operator to ringing by operator id
sub operator_status_set_ringing {
    my ( $self, $operator_id, $p ) = @_;
    $p = { map { $_ => $p->{ $_ } } qw{ number service_id channels } };
    $p->{channels_check} = 1;

    my $status = 'ringing';
    if ( $self->operator_status( $operator_id ) == $STATUS->{busy} ) {
        $status = 'free';
#tolog(3, "ERROR: $p->{number} hanged up closely before connect")
    }
    
    return $self->operator_status( $operator_id, $status, { }, $p );
}

# set status of the operator to free by operator id
sub operator_status_set_free {
    my ( $self, $operator_id, $p ) = @_;
    return $self->operator_status( $operator_id, 'free', { }, $p );
}

# return count of operators by available service
sub operators_online {
    my ( $self, $name, $free ) = @_;

    my $res = $self->{_handler}->resultset( 'OperatorsWorkingCount'.( $free? 'Free' : 'All' ) )
                    ->search( { name => $name } )->first;

    return $res? $res->c : 0;
}

# check if operators not less than default allways free
sub operators_last_vip_service {
    my ( $self, $operator_id ) = @_;
    my $op_rs = $self->{_handler}->resultset( 'OperatorsLastVipService' )->search();
    while ( my $op = $op_rs->next() ) {
        return 1 if $op->c <= $self->{_conf}{operators_default_allways_free} 
                    && $op->operator_id == $operator_id;
    }
    return 0;
}

# count of all online operators
sub operators_online_all {
    my $self = shift;
    $self->{_handler}->resultset( 'OperatorWorking' )->count;
}

# count of busy operators
sub operators_busy {
    my $self = shift;
    $self->{_handler}->resultset( 'OperatorWorking' )
        ->search( { -or => { status => { '!=' => 1 }, timestamp => { '>' => time() } } } )->count;
}

# get operator's password by id
sub operator_password_by_id {
    my ( $self, $operator_id ) = @_;
    my $res = $self->{_handler}->resultset( 'Operator' )
              ->search( { id => $operator_id } )->first;
    return $res? $res->password : undef;
}

# add to operator dnd seconds
sub operator_login_addtime {
    my ( $self, $operator_id, $seconds_add ) = @_;
    return 0 unless $seconds_add;
    my $res = $self->{_handler}->resultset( 'OperatorWorking' )
              ->search( { operator_id => $operator_id } )
              ->update( { timestamp => time()+$seconds_add } );
    return $res == 0? 0 : $res;
}

# add one call with seconds duration
sub operator_login_add_timecall {
    my ( $self, $operator_id, $seconds_add ) = @_;
    return 0 unless $seconds_add;
    my $res = $self->{_handler}->resultset( 'OperatorWorking' )
              ->search( { operator_id => $operator_id } )
              ->update( { calls => \ 'calls + 1', calls_time => \ "calls_time + $seconds_add" } );
    return $res == 0? 0 : $res;
}

# return service by service id
sub service_by_service_id {
    my ( $self, $service_id ) = @_;
    my $res = $self->{_handler}->resultset( 'Service' )
                   ->search( { id => $service_id } )->first;
    return $res? $res->name : '';
}

# return hashref to service by service name
sub get_service_by_service_name {
    my ( $self, $service_name ) = @_;
    my $res = $self->{_handler}->resultset( 'Service' )
                   ->search( { name => $service_name } );
    $res->result_class('DBIx::Class::ResultClass::HashRefInflator');
    return $res->first || {};
}

# add service to opeator
sub add_service_to_operator {
    my ( $self, $service_id, $operator_id, $weight ) = @_;
    $self->{_handler}->resultset( 'OperatorsService' )
               ->create( { service_id => $service_id, 
                         operator_id => $operator_id, 
                         weigth => $weight } );
}

# remove service from operator
sub remove_service_from_operator {
    my ( $self, $service_id, $operator_id ) = @_;
    $self->{_handler}->resultset( 'OperatorsService' )
               ->search( { service_id => $service_id, 
                         operator_id => $operator_id } )
               ->delete;
}

# get service by operator id
sub get_services_by_operator_id {
    my ( $self, $operator_id ) = @_;
    my $res = $self->{_handler}->resultset( 'Service' )
                   ->search( { operator_id => $operator_id }, { join => 'operators_services' } );
    $res->result_class('DBIx::Class::ResultClass::HashRefInflator');
    my @result = $res->all;
    return \@result;
}

# return text of white message by phone number
sub message_white_list {
    my ( $self, $number ) = @_;
    my $res = $self->{_handler}->resultset( 'CallsRule' )
                   ->search( { type => 'white', number => $number } )->first;
    return $res? $res->text : undef;
}

# check if number in black list
sub check_black_list {
    my ( $self, $number, $white ) = @_;
    my $res = $self->{_handler}->resultset( 'CallsRule' )
                   ->search( { type => $white? 'white' : 'black', number => $number } )
                   ->update( { count => \ 'count + 1' } );
    return $res == 0? 0 : $res;
}

# check if number in white list
sub check_white_list {
    my ( $self, $number ) = @_;
    return $self->check_black_list( $number, 'white' );
}

# add incoming to queue
sub client_queue_add {
    my ( $self, $p ) = @_;
    my $res = $self->{_handler}->resultset( 'Queue' )
                ->create( { 
                    service_id => $p->{service_id},
                    weight     => $p->{weight},
                    busy       => 0,
                    number     => $p->{que_number},
                    channel    => $p->{que_channel},
                    time       => \ 'NOW()',
                    time_from  => \ 'NOW()',,
                    timestamp  => time(),
                    timestamp_from => time()
                } );
    return $res;
}

# remove client from queue
sub client_queue_remove{
    my ( $self, $que_id ) = @_;
    my $res = $self->{_handler}->resultset( 'Queue' )
                   ->search( { id => $que_id } )->delete;
    return $res;
}

# count of clients in queue
sub client_queue_total {
    my ( $self, $service_id ) = @_;
    $self->{_handler}->resultset( 'Queue' )
           ->search( { service_id => $service_id, busy => 0 } )
           ->count;
}

# count in queue before queue id by id of service
sub client_queue_place {
    my ( $self, $que_id, $service_id ) = @_;
    $self->{_handler}->resultset( 'Queue' )
           ->search( { id => { '<=' => $que_id }, service_id => $service_id, busy => 0 } )
           ->count;
}

# set client in queue busy
sub client_queue_busy{
    my ( $self, $que_id, $busy ) = @_;
    my $res = $self->{_handler}->resultset( 'Queue' )
                   ->search( { id => $que_id } )->update( { busy => $busy } );
    return $res;
}

# return all clients from queue
sub client_queue_next {
    my $self = shift;
    my @res = $self->{_handler}->resultset( 'ClientQueueNext' )->all;
    return \@res;
}

# list of free online operators
sub operators_free_online {
    my ( $self, $service_id ) = @_;
    my @res = $self->{_handler}->resultset( 'OperatorsFreeOnline' )
                   ->search( { timestamp => { '<', time() }, id => $service_id } )
                   ->all;
    return [] if !@res || !$self->operator_login_addtime( $res[0]->operator_id, 1 );
    return \@res;
}

1;

