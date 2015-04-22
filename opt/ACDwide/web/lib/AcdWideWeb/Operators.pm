package AcdWideWeb::Operators;
use Mojo::Base 'Mojolicious::Controller';

sub index {
    my $self = shift;

    $self->render(
        operators => [
            [ 'aaa', 4, 111, 'ax1' ],
            [ 'vvv', 1, 133, 'bx1' ],
        ],
    );
}

1;
