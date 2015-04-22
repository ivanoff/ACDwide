package SimplenessCMS::MAIN::Laconic;

use strict;
use warnings;

our $VERSION = '0.2';
our @ISA     = qw( Exporter );
our @EXPORT  = qw(
                defaults title header
                ban you_cannot you_can_not
                process process_pdf
                sql
                t lang is_default_lang
                cache
                param
                param_set
                session
                images
            );

sub defaults {
    return $main::tt->{ $_[0] } if ref $_[0] ne 'HASH';
    $main::tt = { %{$main::tt}, %{$_[0]}, };
}

sub title {
    defaults { title => $_[0] };
}

sub header {
    $_ = shift;
    my $params = shift;
    $params->{charset} ||= 'utf-8';
    /404/  && return $main::header = "Status: 404 Not Found\n\n";
    /html|clear/ && do {$main::header = "Content-type: text/html; charset=$params->{charset};"};
    /xml/  && do {$main::header = "Content-type: text/xml; charset=$params->{charset};"};
    /json/ && do {$main::header = "Content-type: application/json; charset=$params->{charset};"};
    /gif/  && do {$main::header = "Content-type: image/gif;"};
    /pdf/  && do { $::header = "Content-type: application/pdf\nContent-Disposition: attachment; filename=$params->{filename};" };
    /rtf/  && do { $::header = "Content-Type: application/rtf\nContent-Disposition: attachment; filename=$params->{filename};" };
    if ( $params->{no_cache} ) {
        $main::header .= "\nCache-Control: no-cache, must-revalidate\nExpires: Sat, 26 Jul 1997 05:00:00 GMT;";
    }
}

sub ban {
    return ( $main::tt->{access}{$_[0]} )? 0 : "permission denied";
}

sub you_cannot {
    ban(@_)
}

sub you_can_not {
    ban(@_)
}

sub process {
    return $main::template->process( @_ );
}

sub sql {
    return $main::db->sql( @_ );
}

sub t {
    $main::t->t( @_ );
}

sub lang {
    return $main::CONFIG->{default_language} if @_ && $_[0] =~ /^default$/i;
    return $main::t->{'language'};
}

sub is_default_lang {
    my $lang = shift || lang;
    return $lang eq lang('default');
}

sub cache {
    my $cache_time = shift;
    $::CONFIG->{cache}{all} = ($cache_time)? 1 : 0;
}

sub param {
    return $main::q->Vars unless @_;
    return $main::q->param( $_[0] ) unless $_[1];
    return map { $main::q->param( $_ ) } @_;
}

sub param_set {
    return $main::q->param( @_ );
}

sub session {
    return $main::SESSION->param( @_ ) if @_;
    $main::SESSION->delete();
    $main::SESSION->flush();
    return 1;
}

sub images {
    return $main::CONFIG_IMAGES->{$_[0]} if @_;
}

1;
