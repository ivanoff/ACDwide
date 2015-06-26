package AcdWideWeb::Main;
use Mojo::Base 'Mojolicious::Controller';

sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(
    message => 'Welcome to the Mojolicious real-time web framework!'),
}

1;
