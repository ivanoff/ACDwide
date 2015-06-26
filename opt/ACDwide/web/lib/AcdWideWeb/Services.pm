package AcdWideWeb::Services;
use Mojo::Base 'Mojolicious::Controller';

sub table {
    my $self = shift;

    $self->render(
        template => 'table/index',
        title    => 'Services',
        fields   => [ qw{ name weight message service_order access_type extensions } ],
        info     => [ $self->db->resultset('Service')->search ],
    );
}

sub add {
    my $self = shift;

    $self->render(
        json => {x => 3},
#        template => 'table/add',
#        fields => [ qw{ name weight message service_order access_type extensions } ],
#        info   => [ $self->db->resultset('Service')->search ],
    );
}

1;
