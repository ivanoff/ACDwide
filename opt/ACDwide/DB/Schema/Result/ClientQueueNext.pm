package ACDwide::DB::Schema::Result::ClientQueueNext;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::ClientQueueNext

=cut

__PACKAGE__->table("client_queue_next");

=head1 ACCESSORS

=head2 min

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns("min", { data_type => "integer", is_nullable => 1 });


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-22 18:58:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:53CbGGGMeG/tDOwu68Krpw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
