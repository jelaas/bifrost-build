#!/bin/bash

SRC=telnet-bsd-1.2.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://sunsite.icm.edu.pl/pub/Linux/distributions/suse/people/kukuk/ipv6/$SRC || wget -O $DST ftp://ftp.suse.com/pub/people/kukuk/ipv6/$SRC
