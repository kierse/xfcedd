#!/usr/bin/perl -wT

use POSIX;

# to setup daemon, need to fork off child process that is
# not associated with the process that started the parent
#
my $pid = fork;
exit if $pid;
die "Couldn't fork: $!" unless defined($pid);

# Dissociate from the controlling terminal that started parent
# and stop being part of whatever process group we had been a member of.
#
POSIX::setsid() or die "Can't start a new session: $!";

# trap fatal signals and set flag indicating we need to exit gracefully
#
my $time_to_die = 0;
sub signal_handler
{
	$time_to_die = 1;
}

# trap or ignore $SIG{PIPE}
#
$SIG{INT} = $SIG{TERM} = $SIG{HUP} = \&signal_handler;

# daemon code
#
until ($time_to_die)
{
	sleep(10);
	$time_to_die = 1;
}

