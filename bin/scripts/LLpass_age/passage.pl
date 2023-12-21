#!/bin/perl

#	Derek Maurer
#	dmaurer@opentext.com	2:26 PM 2/28/2005
#
#	passage.pl
#	Checks DB stored passwords for LL for last changed date.  This is according to last run of script.
#	No passwords are stored locally, local DB only holds crc and date information.
#
#	Usage:
#	passage.pl {DSN name} {username} {password} {LL_DB_name} 
#
#	Output:
#	DSN/LL_DB_name		Username		Min_Last_Password_Change_Date
#							(MM/DD/YYYY)
#	----------------	--------		-----------------------------
#	testb2b/b2bscene	Admin			01/28/2005
#	testb2b/b2bscene	monitor			01/28/2005
#	testb2b/b2bscene	otmonitor		01/28/2005
#	testb2b/b2bscene	elink			01/28/2005
#
#	Future:
#	passage.pl {DSN name} {username} {password} {LL_DB_name}  [-i {instance},{host1,host2,...}]
#	
#	-to check DB aswell as webadmin passwords (from opentext.ini hash)
#	-email notification for 14+ days to hosting policy set password age limit
#	-pass to Sitescope/Spong for notification
#	-DB track history for changes
#	-simple report from 'DB', ie view all old than date
#

# check args

# build constants

# test DSN connection



###########################################3
## test code starts here

 use DBI;

#open connection to Access database
	$dbh = DBI->connect('dbi:ODBC:LLDBTEST');

#construct SQL statement
$sqlstatement="SELECT Name,UserPWD FROM KUAF";

#prepare and execute SQL statement
$sth = $dbh->prepare($sqlstatement);
$sth->execute || 
      die "Could not execute SQL statement, maybe invalid?";

@row=$sth->fetchrow_array;

#output database results
	while (@row=$sth->fetchrow_array)
	 { print "@row\n" }

