package ACDwide::DB::Schema::Result::Location;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::Location

=cut

__PACKAGE__->table("location");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'location_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 ip

  data_type: 'inet'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "location_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 1 },
  "ip",
  { data_type => "inet", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-17 23:49:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Di+wIS4Ha0XC514BuhPpsw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
