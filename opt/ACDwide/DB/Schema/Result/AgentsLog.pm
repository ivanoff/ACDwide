package ACDwide::DB::Schema::Result::AgentsLog;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::AgentsLog

=cut

__PACKAGE__->table("agents_logs");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'agents_logs_id_seq'

=head2 dt

  data_type: 'timestamp'
  is_nullable: 1

=head2 agent

  data_type: 'integer'
  is_nullable: 1

=head2 event

  data_type: 'integer'
  is_nullable: 1

=head2 callerid

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 timer

  data_type: 'integer'
  is_nullable: 1

=head2 acdgroup

  data_type: 'varchar'
  default_value: 0
  is_nullable: 1
  size: 16

=head2 extention

  data_type: 'text'
  is_nullable: 1

=head2 beforeanswer

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 dialstatus

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 begin_time

  data_type: 'timestamp'
  is_nullable: 1

=head2 record_id

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
    sequence          => "agents_logs_id_seq",
  },
  "dt",
  { data_type => "timestamp", is_nullable => 1 },
  "agent",
  { data_type => "integer", is_nullable => 1 },
  "event",
  { data_type => "integer", is_nullable => 1 },
  "callerid",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "timer",
  { data_type => "integer", is_nullable => 1 },
  "acdgroup",
  { data_type => "varchar", default_value => 0, is_nullable => 1, size => 16 },
  "extention",
  { data_type => "text", is_nullable => 1 },
  "beforeanswer",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "dialstatus",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "begin_time",
  { data_type => "timestamp", is_nullable => 1 },
  "record_id",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("agents_logs_dt_key", ["dt", "agent", "event", "callerid"]);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-17 23:49:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RdxhdtpHNhK3Q4Xm5MyidA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
