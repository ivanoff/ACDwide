package ACDwide::DB::Schema::Result::Service;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::Service

=cut

__PACKAGE__->table("services");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'services_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 weight

  data_type: 'integer'
  is_nullable: 1

=head2 message

  data_type: 'text'
  is_nullable: 1

=head2 service_order

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 access_type

  data_type: 'smallint'
  default_value: 0
  is_nullable: 1

=head2 extensions

  data_type: 'character varying[]'
  is_nullable: 1
  size: 60

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "services_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 1 },
  "weight",
  { data_type => "integer", is_nullable => 1 },
  "message",
  { data_type => "text", is_nullable => 1 },
  "service_order",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "access_type",
  { data_type => "smallint", default_value => 0, is_nullable => 1 },
  "extensions",
  { data_type => "character varying[]", is_nullable => 1, size => 60 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 operators_services

Type: has_many

Related object: L<ACDwide::DB::Schema::Result::OperatorsService>

=cut

__PACKAGE__->has_many(
  "operators_services",
  "ACDwide::DB::Schema::Result::OperatorsService",
  { "foreign.service_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 operators_services

Type: has_many

Related object: L<ACDwide::DB::Schema::Result::OperatorsService>

=cut

__PACKAGE__->has_many(
  "operators_services",
  "ACDwide::DB::Schema::Result::OperatorsService",
  { "foreign.service_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-22 20:01:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dfLyjey6mgxD42SE8V2tLA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
