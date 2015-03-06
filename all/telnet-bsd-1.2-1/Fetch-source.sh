#!/bin/bash

SRC=telnet-bsd-1.2.tar.bz2
DST=/var/spool/src/$SRC
MD5=72d72c65e7796dfec999f347da1c295f

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/suse/people/kukuk/ipv6/$SRC \
              || wget -O $DST ftp://ftp.suse.com/pub/people/kukuk/ipv6/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
