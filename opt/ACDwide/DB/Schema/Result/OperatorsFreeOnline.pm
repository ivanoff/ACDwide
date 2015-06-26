package ACDwide::DB::Schema::Result::OperatorsFreeOnline;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::OperatorsFreeOnline

=cut

__PACKAGE__->table("operators_free_online");

=head1 ACCESSORS

=head2 operator_id

  data_type: 'integer'
  is_nullable: 1

=head2 weight

  data_type: 'integer'
  is_nullable: 1

=head2 timestamp

  data_type: 'integer'
  is_nullable: 1

=head2 id

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "operator_id",
  { data_type => "integer", is_nullable => 1 },
  "weight",
  { data_type => "integer", is_nullable => 1 },
  "timestamp",
  { data_type => "integer", is_nullable => 1 },
  "id",
  { data_type => "integer", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-23 15:13:25
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:isX5PouZ+jauis3SwGunzw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
