package ACDwide::Logs;

use strict;
use warnings;
use Log::Log4perl;

sub new {
    my ( $class, $conf ) = @_;

    $conf->{'files_log'} ||= 'acdwide.log';
    $conf->{'files_callers_dump'} ||= 'acdwide_callers.log';

    my @log_name = map { s/files_//; $_ } grep { /^files_/ } keys %$conf;

    my $log_cfg = q (
            log4perl.logger.ACDwide.[%name%]            = DEBUG,  [%name%]Apender
            log4perl.appender.[%name%]Apender           = Log::Log4perl::Appender::File
            log4perl.appender.[%name%]Apender.filename  = [%path%] 
            log4perl.appender.[%name%]Apender.layout    = PatternLayout
            log4perl.appender.[%name%]Apender.utf8      = 1
            log4perl.appender.[%name%]Apender.layout.ConversionPattern=[%d] %F %L %c - %m%n
            log4perl.appender.[%name%]Apender.recreate  = 10
    );

    my $logs_config;
    foreach my $logname ( @log_name ){
        $_ = $log_cfg; 
        s/\[\%\s*name\s*\%\]/$logname/g; 
        s/\[\%\s*path\s*\%\]/$conf->{'files_'.$logname}/g; 
        $logs_config .= $_;
    }
    
    Log::Log4perl::init( \$logs_config );

    my $self;
    $self->{$_} = Log::Log4perl->get_logger('ACDwide.'.$_) foreach @log_name;

    bless $self, ref $class || $class;

    return $self;
}

sub debug {
    my ( $self, $text ) = @_;
    $log->{log}->debug( $text );
}

sub call {
    my ( $self, $text ) = @_;
    $log->{callers_dump}->debug( $text );
}

1;