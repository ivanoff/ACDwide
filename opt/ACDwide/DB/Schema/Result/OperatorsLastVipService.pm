package ACDwide::DB::Schema::Result::OperatorsLastVipService;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::OperatorsLastVipService

=cut

__PACKAGE__->table("operators_last_vip_service");

=head1 ACCESSORS

=head2 c

  data_type: 'bigint'
  is_nullable: 1

=head2 operator_id

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "c",
  { data_type => "bigint", is_nullable => 1 },
  "operator_id",
  { data_type => "integer", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-18 00:42:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3bsxdHurcvHvDHsJ5d0gFQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
