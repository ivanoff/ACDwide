#!/usr/bin/perl -w

    use strict;

    my $conf;
    open (CONFIGFILE, 'message.conf') or die('message.conf is not exists');
    while (my $line = <CONFIGFILE>) {
        if ($line =~ /^[\ \t]*([^=\ \t]+)[\ \t]*=[\ \t]*(.*)[\ \t]*/) {
	    $conf->{$1} = $2;
        }                           
    }
    close CONFIGFILE;


    use Win32::GUI();

    my $file = $conf->{temp_file};
    unlink $file;

    my ( $w, $h ) = ( $conf->{windows_width}, $conf->{windows_height} );
    my $message_wait = $conf->{message_wait};
    my $message_wait_q = $message_wait;

    my $text = 'Loading...';

    my $main = Win32::GUI::Window->new(
	-name => 'Main', 
	-text => 'Perl',
	-topmost => 1,
	-minsize => [ $w, $h ],
    );


    my $font = Win32::GUI::Font->new(
        -name => $conf->{font_type}, 
        -size => $conf->{font_size},
    );

    my $label = $main->AddLabel(-text => $text, -font => $font,);


    my $ncw = $w  - $main->ScaleWidth();
    my $nch = $h - $main->ScaleHeight();

    $ncw = $w - $main->ScaleWidth();
    $nch = $h - $main->ScaleHeight();

    $main->Resize($w, $h);


    my $desk = Win32::GUI::GetDesktopWindow();
    my $dw = Win32::GUI::Width($desk);
    my $dh = Win32::GUI::Height($desk);
    my $x = ($dw - $w) / 2;
    my $y = ($dh - $h) / 2;
    $main->Move($x, $y);


    $main->AddButton(
        -name => "Button1",
        -text => "Close the window",
        -pos  => [ ($w-120)/2, $h-56, ],
	-cancel => 1,
    );

    sub Button1_Click {
        $main->Disable();
        $main->Hide();
        return 1;
    }


    $main->AddTimer('T1', 1000);
    sub T1_Timer {
	return 1 unless -e $file;

	open F, $file;
	$_ = join '', <F>;
	close F;
	if ( $_ eq $text ) {
	    unless ( --$message_wait_q ) {
            	$main->Disable();
            	$main->Hide();
	    }
	    return 1;
	}

	$text = $_;
	return 1 unless $text;

	$message_wait_q = $message_wait;
	$label->Hide();
    	$label = $main->AddLabel(-text => $text, -font => $font, -align => 'center', -width => 700, );

        $main->Enable();
        $main->Show();

	return 1;
    }


    my $icon = new Win32::GUI::Icon('guiperl.ico');
    my $ni = $main->AddNotifyIcon(
        -name => "NI",
        -icon => $icon,
        -tip => "Hello"
    );


    sub Main_Minimize {
        $main->Disable();
        $main->Hide();
        return 1;
    }

    sub NI_Click {
        $main->Enable();
        $main->Show();
        return 1;
    }
    
    sub Main_Terminate {
        $main->Disable();
        $main->Hide();
        return 1;
    }


my $kidpid = fork();
die "cant fork: $!" unless defined( $kidpid );

if ($kidpid) {

#    $main->Show();
    Win32::GUI::Dialog();

} else {


    use strict;
    use Socket;
    use IO::Socket::INET;

    my $PORT = $conf->{input_port};
    my $server = IO::Socket::INET->new( Proto => 'tcp', LocalPort => $PORT, Listen => SOMAXCONN, Reuse => 1);

    while ( my $client = $server->accept() ) {

	$client->autoflush(1);

        while ( <$client>) {

	    my %in;
	    while ( /.*?"(.*?)".*?:.*?"(.*?)".*?,/gms ) {
		$in{lc $1} = $2;
	    }
	    $in{show} = 1 unless defined $in{show};

            if ( $in{show} ) {
#		$in{title} =~ s/\\n//g ;
	        open F, '>', $file;
	        print F $in{title};
	        close F;
	    }

	} continue {

	}

	close $client;

    }


}



1;
