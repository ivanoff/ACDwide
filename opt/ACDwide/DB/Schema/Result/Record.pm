package ACDwide::DB::Schema::Result::Record;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::Record

=cut

__PACKAGE__->table("records");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'records_id_seq'

=head2 date

  data_type: 'timestamp'
  is_nullable: 1

=head2 file_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 uniqueid

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 context

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 extension

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 callerid

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "records_id_seq",
  },
  "date",
  { data_type => "timestamp", is_nullable => 1 },
  "file_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "uniqueid",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "context",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "extension",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "callerid",
  { data_type => "varchar", is_nullable => 1, size => 100 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-17 23:49:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mGuFQUMx4x7eHFe3CN4/Ew


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
