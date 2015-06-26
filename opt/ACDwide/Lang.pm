package ACDwide::Lang;

use utf8;

# new( \@list_of_languages )
# example: my $langs = new ACDwide::Lang( [ 'en', 'fr', 'ru' ] );
sub new {
    my ( $class, $lang_list ) = @_;
    $lang_list ||= [ 'en' ];
    my $self = { _LANG_LIST => $lang_list };
    bless $self, ref $class || $class;

    foreach my $l ( @$lang_list ) {
        $self->{$l} = eval "use ACDwide::Lang::${l}; \$ACDwide::Lang::${l}::lexicon";
        push @{ $self->{_ERRORS} }, $@ if $@;
        $self->{_DEFAULT} ||= $l;
    }

    $self->{_CURRENT} = $self->{_DEFAULT};
    return $self;
}

# translate( $language, $text, [ $text, ... ] )
# example:  my @translated = $self->translate( 'fr', 'Hello, my friend!', 'Regards' );
sub translate {
    my ( $self, $lang, @texts ) = @_;
    $lang ||= $self->{_DEFAULT};
    my @result = map{ $self->{ $lang }{ $_ } || $_ } @texts;
    return wantarray ? @result : $result[0];
}

sub lang {
    my $self = shift;
    return $self->{_CURRENT} unless @_;
    return $self->{_CURRENT} = shift;
}

sub t {
    my $self = shift;
    $self->translate( $self->{_CURRENT}, @_ );
}

1;