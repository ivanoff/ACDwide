#!/usr/bin/perl -w

use strict;
use utf8;
use Test::More tests => 16;

use lib '../';
use ACDwide::Lang;

my $builder = Test::More->builder;
binmode $builder->output,         ":utf8";

require_ok( 'ACDwide::Lang' );
my $lang = new ACDwide::Lang( [ 'en', 'de' ] );

isa_ok( $lang, 'ACDwide::Lang' );

can_ok( $lang, ( 'translate' ) );

ok(  $lang->translate( 'en', 'Operators' ) eq 'Operators', 'translate Operators en->en' );
ok(  $lang->translate( 'de', 'Operators' ) eq 'Betreiber', 'translate Operators en->de' );
my @r = $lang->translate( 'de', 'Services', 'Access' );
ok(  $r[0] eq 'Dienstleistungen', 'translate Services en->de' );
ok(  $r[1] eq 'Zugang', 'translate Access en->de' );

ok(  $lang->lang eq 'en', 'Current lang is en' );
ok(  $lang->t( 'Operators' ) eq 'Operators', 'Operators to en' );
@r = $lang->t( 'Services', 'Access' );
ok(  $r[0] eq 'Services', 'Services to en' );
ok(  $r[1] eq 'Access', 'Access to en' );

ok(  $lang->lang( 'de' ) eq 'de', 'Switch current lang to de' );
ok(  $lang->lang eq 'de', 'Current lang is de' );
ok(  $lang->t( 'Operators' ) eq 'Betreiber', 'Operators to de' );
@r = $lang->t( 'Services', 'Access' );
ok(  $r[0] eq 'Dienstleistungen', 'Services to de' );
ok(  $r[1] eq 'Zugang', 'Access to de' );

