#!/usr/bin/perl -w

use strict;
use IO::Socket::INET;

# server is running
#
my $path = $ENV{'HOME'} . "/.xfce4/.xfcedd=";
if(-e $path)
{
	# get port of running server
	#
	open(PORT, "<", $path);
	my $port = <PORT>;
	close(PORT);

	# open a socket to running server
	#
	my $socket = new IO::Socket::INET
	(
		PeerAddr => "Localhost",
		PeerPort => $port,
		Proto    => "tcp",
		Type     => SOCK_STREAM,
	) or die "Couldn't open socket to server: $!\n";

	# send message over the socket
	#
	print $socket "Hello Server!\n";

	# read the answer
	#
	my $response = <$socket>;
	print $response;

	# close socket connection
	#
	close($socket);
}

# no server running!  Notify users
#
else
{
	print "Oops, no server available!\n";
	exit;
}
