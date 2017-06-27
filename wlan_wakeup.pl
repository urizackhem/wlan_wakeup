#!/usr/bin/perl

use strict;
use warnings;

use Net::Ping;

my $host = "192.168.1.1";

my $p = Net::Ping->new();
if ($p->ping($host))
{
	print "Network's ON\n";
	$p->close();
}else{
	$p->close();
	print "Network's DOWN\n";
	my $wlan = "wlan0";
	`ifdown $wlan`;
	sleep(5);
	`ifup --force $wlan`;
	if (not ($p->ping($host)) )
	{	
		`sudo shutdown -h now`;
	}
	$p->close();
}

print "Finished\n";
