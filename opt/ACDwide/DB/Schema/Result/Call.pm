package ACDwide::DB::Schema::Result::Call;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::Call

=cut

__PACKAGE__->table("calls");

=head1 ACCESSORS

=head2 id1

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'calls_id1_seq1'

=head2 id

  data_type: 'bigint'
  is_nullable: 1

=head2 dt

  data_type: 'timestamp'
  is_nullable: 1

=head2 acdgroup

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 agent

  data_type: 'integer'
  is_nullable: 1

=head2 status

  data_type: 'smallint'
  is_nullable: 1

=head2 beforeanswer

  data_type: 'integer'
  is_nullable: 1

=head2 answertime

  data_type: 'integer'
  is_nullable: 1

=head2 queuetime

  data_type: 'integer'
  is_nullable: 1

=head2 queuecount

  data_type: 'integer'
  is_nullable: 1

=head2 callerid

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 exten

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 holdtime

  data_type: 'integer'
  is_nullable: 1

=head2 crossid

  data_type: 'integer'
  is_nullable: 1

=head2 operator

  data_type: 'varchar'
  is_nullable: 1
  size: 1

=cut

__PACKAGE__->add_columns(
  "id1",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "calls_id1_seq1",
  },
  "id",
  { data_type => "bigint", is_nullable => 1 },
  "dt",
  { data_type => "timestamp", is_nullable => 1 },
  "acdgroup",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "agent",
  { data_type => "integer", is_nullable => 1 },
  "status",
  { data_type => "smallint", is_nullable => 1 },
  "beforeanswer",
  { data_type => "integer", is_nullable => 1 },
  "answertime",
  { data_type => "integer", is_nullable => 1 },
  "queuetime",
  { data_type => "integer", is_nullable => 1 },
  "queuecount",
  { data_type => "integer", is_nullable => 1 },
  "callerid",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "exten",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "holdtime",
  { data_type => "integer", is_nullable => 1 },
  "crossid",
  { data_type => "integer", is_nullable => 1 },
  "operator",
  { data_type => "varchar", is_nullable => 1, size => 1 },
);
__PACKAGE__->set_primary_key("id1");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-17 23:49:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+/NyanIuiECkRCk0WSQuwg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
