package ACDwide::DB::Schema::Result::OperatorsWorkingCountFree;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::OperatorsWorkingCountFree

=cut

__PACKAGE__->table("operators_working_count_free");

=head1 ACCESSORS

=head2 c

  data_type: 'bigint'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "c",
  { data_type => "bigint", is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-17 23:49:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oROlXcCxgIYDjsnbQJ26ZQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
