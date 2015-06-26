package ACDwide::DB::Schema::Result::OperatorWorking;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::OperatorWorking

=cut

__PACKAGE__->table("operators_working");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'operators_working_id_seq'

=head2 operator_id

  data_type: 'integer'
  is_nullable: 1

=head2 time

  data_type: 'timestamp'
  is_nullable: 1

=head2 status

  data_type: 'integer'
  is_nullable: 1

=head2 location

  data_type: 'text'
  is_nullable: 1

=head2 calls

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 calls_time

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 rate

  data_type: 'integer'
  is_nullable: 1

=head2 number

  data_type: 'text'
  is_nullable: 1

=head2 service_id

  data_type: 'integer'
  is_nullable: 1

=head2 channels

  data_type: 'text'
  is_nullable: 1

=head2 channels_check

  data_type: 'integer'
  is_nullable: 1

=head2 state

  data_type: 'smallint'
  default_value: 0
  is_nullable: 1

=head2 timestamp

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "operators_working_id_seq",
  },
  "operator_id",
  { data_type => "integer", is_nullable => 1 },
  "time",
  { data_type => "timestamp", is_nullable => 1 },
  "status",
  { data_type => "integer", is_nullable => 1 },
  "location",
  { data_type => "text", is_nullable => 1 },
  "calls",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "calls_time",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "rate",
  { data_type => "integer", is_nullable => 1 },
  "number",
  { data_type => "text", is_nullable => 1 },
  "service_id",
  { data_type => "integer", is_nullable => 1 },
  "channels",
  { data_type => "text", is_nullable => 1 },
  "channels_check",
  { data_type => "integer", is_nullable => 1 },
  "state",
  { data_type => "smallint", default_value => 0, is_nullable => 1 },
  "timestamp",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-17 23:49:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BAWppka9yKPcjHFgO09NGA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
