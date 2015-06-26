package ACDwide::DB::Schema::Result::CallsRule;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::CallsRule

=cut

__PACKAGE__->table("calls_rules");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'calls_rules_id_seq'

=head2 date

  data_type: 'timestamp'
  is_nullable: 1

=head2 type

  data_type: 'enum'
  extra: {custom_type_name => "list_type",list => ["white","black"]}
  is_nullable: 1

=head2 number

  data_type: 'text'
  is_nullable: 1

=head2 count

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 text

  data_type: 'text'
  is_nullable: 1

=head2 service

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "calls_rules_id_seq",
  },
  "date",
  { data_type => "timestamp", is_nullable => 1 },
  "type",
  {
    data_type => "enum",
    extra => { custom_type_name => "list_type", list => ["white", "black"] },
    is_nullable => 1,
  },
  "number",
  { data_type => "text", is_nullable => 1 },
  "count",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "text",
  { data_type => "text", is_nullable => 1 },
  "service",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-17 23:49:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9Hvym5RkloS3+uVQYnUPsg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
