package ACDwide::DB::Schema::Result::OperatorsLanguage;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

ACDwide::DB::Schema::Result::OperatorsLanguage

=cut

__PACKAGE__->table("operators_languages");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'operators_languages_id_seq'

=head2 operator_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 lang_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "operators_languages_id_seq",
  },
  "operator_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "lang_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

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

=head2 lang

Type: belongs_to

Related object: L<ACDwide::DB::Schema::Result::Language>

=cut

__PACKAGE__->belongs_to(
  "lang",
  "ACDwide::DB::Schema::Result::Language",
  { id => "lang_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2015-06-17 23:49:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CvDJyiaZCRl95whUduqrEA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
