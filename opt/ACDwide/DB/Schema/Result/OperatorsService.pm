package ACDwide::DB::Schema::Result::OperatorsService;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::OperatorsService

=cut

__PACKAGE__->table("operators_services");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'operators_services_id_seq'

=head2 service_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 operator_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 weigth

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "operators_services_id_seq",
  },
  "service_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "operator_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "weigth",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 service

Type: belongs_to

Related object: L<ACDwide::DB::Schema::Result::Service>

=cut

__PACKAGE__->belongs_to(
  "service",
  "ACDwide::DB::Schema::Result::Service",
  { id => "service_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 operator

Type: belongs_to

Related object: L<ACDwide::DB::Schema::Result::Operator>

=cut

__PACKAGE__->belongs_to(
  "operator",
  "ACDwide::DB::Schema::Result::Operator",
  { id => "operator_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 service

Type: belongs_to

Related object: L<ACDwide::DB::Schema::Result::Service>

=cut

__PACKAGE__->belongs_to(
  "service",
  "ACDwide::DB::Schema::Result::Service",
  { id => "service_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-22 20:01:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/rlUAmC5JMqRJQCDqcxS+Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
