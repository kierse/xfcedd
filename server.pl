#!/usr/bin/perl -w

use strict;
use IO::Socket::INET;

# acquire socket
#
my $server = new IO::Socket::INET(
#	LocalPort => INADDR_ANY,
	Type      => SOCK_STREAM,
	Reuse     => 1,
	Listen    => 10
) or die "Couldn't acquire socket: $!\n";

# write out temporary file with port number
#
my $socketPort = $server->sockport();
my $path = $ENV{'HOME'} . "/.xfce4/.xfcedd=";
open(PORT, ">", $path);
print PORT $socketPort;
close(PORT);

while(my $client = $server->accept())
{
	# $client is the new connection...
	#
	my $socket_address = $client->sockname();
	my ($port, $myaddr)   = sockaddr_in($socket_address);
	my $request = <$client>;
	print "Client request: $request\n";
	print $client "hello\n";
	close $client;
}

# delete the file pointing to the port
#
unlink($path);

# close the open socket
#
close($server);

