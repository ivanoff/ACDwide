package AcdWideWeb::Operators;
use Mojo::Base 'Mojolicious::Controller';

sub dd {
    return {
        fields  => [ qw{ id password name manager_id can_outgoing date_hire date_fired } ],
        types   => {
            id     => [ qw{ id } ],
            hidden => [ qw{ id } ],
            date   => [ qw{ date_hire date_fired } ],
        },
    }
};

sub table {
    my $self = shift;

    $self->render(
        template => 'table/index',
        title    => 'Operators',
        info     => [ $self->db->resultset('Operator')->search ],
        %{$self->dd},
    );

}

sub add {
    my $self = shift;

    my $row = $self->db->resultset('Operator')->create({
        map { $_ => $self->param( $_ ) } 
            grep { $self->param( $_ ) } 
            @{ $self->dd->{fields} } 
    });

    $self->render(
        json  => {
            result => 'ok',
            id => $row->id,
#            error => $self->param('password').'???',
        },
    );
}

sub edit {
    my $self = shift;

    my $id = $self->dd->{types}{id}[0];
return    $self->render(
        json  => {
            result => 'ok',
            id => $id,
            error => $self->param('id').'?!?'.$id,
        },
    );

    $self->db->resultset('Operator')->find({
        $id => $self->param( $id ) 
    })->update(
        map { $_ => $self->param( $_ ) } 
            grep { $self->param( $_ ) } 
            @{ $self->dd->{fields} } 
    );

    $self->render(
        json  => {
            result => 'ok',
            id => $id,
#            error => $self->param('password').'???',
        },
    );
}

sub remove {
    my $self = shift;

    my $id = $self->dd->{types}{id}[0];
    $self->db->resultset('Operator')->search({
        $id => $self->param( $id ) 
    })->delete;

    $self->render(
        json  => {
            result => 'ok',
#            error => $self->param('id').'???'.$id,
        },
    );
}

1;
