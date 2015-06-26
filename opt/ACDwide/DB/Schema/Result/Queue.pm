package ACDwide::DB::Schema::Result::Queue;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::Queue

=cut

__PACKAGE__->table("queues");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'queues_id_seq'

=head2 service_id

  data_type: 'integer'
  is_nullable: 1

=head2 weight

  data_type: 'integer'
  is_nullable: 1

=head2 busy

  data_type: 'integer'
  is_nullable: 1

=head2 time

  data_type: 'timestamp'
  is_nullable: 1

=head2 number

  data_type: 'text'
  is_nullable: 1

=head2 channel

  data_type: 'text'
  is_nullable: 1

=head2 time_from

  data_type: 'timestamp'
  is_nullable: 1

=head2 timestamp

  data_type: 'integer'
  is_nullable: 1

=head2 timestamp_from

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "queues_id_seq",
  },
  "service_id",
  { data_type => "integer", is_nullable => 1 },
  "weight",
  { data_type => "integer", is_nullable => 1 },
  "busy",
  { data_type => "integer", is_nullable => 1 },
  "time",
  { data_type => "timestamp", is_nullable => 1 },
  "number",
  { data_type => "text", is_nullable => 1 },
  "channel",
  { data_type => "text", is_nullable => 1 },
  "time_from",
  { data_type => "timestamp", is_nullable => 1 },
  "timestamp",
  { data_type => "integer", is_nullable => 1 },
  "timestamp_from",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-17 23:49:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WmKR1TuMUKLDA+ampIJ4OQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
