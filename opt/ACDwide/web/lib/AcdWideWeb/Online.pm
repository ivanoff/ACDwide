package AcdWideWeb::Online;
use Mojo::Base 'Mojolicious::Controller';

sub table {
    my $self = shift;

    $self->render(
        info     => [ $self->db->resultset('OperatorWorking')->search ],
        template => 'online/index',
    );

}

1;
