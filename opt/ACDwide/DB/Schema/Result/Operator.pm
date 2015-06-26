package ACDwide::DB::Schema::Result::Operator;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::Operator

=cut

__PACKAGE__->table("operators");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'operators_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 password

  data_type: 'text'
  is_nullable: 1

=head2 manager_id

  data_type: 'integer'
  is_nullable: 1

=head2 date_hire

  data_type: 'date'
  is_nullable: 1

=head2 date_fired

  data_type: 'date'
  is_nullable: 1

=head2 can_outgoing

  data_type: 'smallint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "operators_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 1 },
  "password",
  { data_type => "text", is_nullable => 1 },
  "manager_id",
  { data_type => "integer", is_nullable => 1 },
  "date_hire",
  { data_type => "date", is_nullable => 1 },
  "date_fired",
  { data_type => "date", is_nullable => 1 },
  "can_outgoing",
  { data_type => "smallint", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 operators_languages

Type: has_many

Related object: L<ACDwide::DB::Schema::Result::OperatorsLanguage>

=cut

__PACKAGE__->has_many(
  "operators_languages",
  "ACDwide::DB::Schema::Result::OperatorsLanguage",
  { "foreign.operator_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 operators_services

Type: has_many

Related object: L<ACDwide::DB::Schema::Result::OperatorsService>

=cut

__PACKAGE__->has_many(
  "operators_services",
  "ACDwide::DB::Schema::Result::OperatorsService",
  { "foreign.operator_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-17 23:49:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lJ8KJ/RjmmGKQdxpKTNTSg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
