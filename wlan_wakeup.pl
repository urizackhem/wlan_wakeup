#!/usr/bin/perl

use strict;
use warnings;
# Install this nice module.
use Net::Ping;
# The IP address of your router. Can be different, like 10.0.0.1
my $host = "192.168.1.1";
# Instantiate
my $p = Net::Ping->new();
if ($p->ping($host))
{       # Everything's hunky dory.
	print "Network's ON\n";
	$p->close();
}else{
	$p->close();
	# Try to shut down the wifi and revive it.
	print "Network's DOWN\n";
	my $wlan = "wlan0";
	`ifdown $wlan`;
	sleep(5);
	`ifup --force $wlan`;
	sleep(5);
	if (not ($p->ping($host)) )
	{	# Emergency powers...
		`sudo reboot -h now`;
	}
	$p->close();
	print "Network's UP now\n";
}

print "Finished\n";
