package AcdWideWeb;
use Mojo::Base 'Mojolicious';

use lib '../../';
use ACDwide::Config;
use ACDwide::DB::Schema;
use ACDwide::Lang;

my $conf = new ACDwide::Config( '/etc/ACDwide/main.conf' );

has schema => sub {
    ACDwide::DB::Schema->connect(
        'dbi:Pg:dbname='.$conf->{base_name}.' host='.$conf->{base_host}.' port='.$conf->{base_port}, 
        $conf->{base_login}, $conf->{base_password}, {
            quote_names => 1,
#            mysql_enable_utf8 => 1,
        });
};

sub startup {
  my $self = shift;
  $self->secret('IsJDv2jc7F9fencU');

  $self->plugin(charset => {charset => 'utf8'});

  $self->helper( db => sub { $self->app->schema } );

  my @langs_list = grep {/\S/} map { s/\s//g; $_ } split ',', $conf->{langs};
  my $langs = new ACDwide::Lang( \@langs_list );
  $self->helper(
    l => sub { 
        my $self = shift;
        $self->req->headers->host =~ /^(\w{2})\./;
        return $langs->translate( $1, @_ );
    } );

  my $r = $self->routes;

  $r->get  ( '/' )->to( 'index#main' );

  $r->get  ( '/operators/'       )->to( 'operators#table'  );
  $r->post ( '/operators/add/'   )->to( 'operators#add'    );
  $r->post ( '/operators/edit/'  )->to( 'operators#edit'   );
  $r->post ( '/operators/remove/')->to( 'operators#remove' );

  $r->get  ( '/services/'     )->to( 'services#table'  );
  $r->get  ( '/services/add/' )->to( 'services#add'    );
  
  $r->get  ('/online/')->to('online#table');

}

1;
