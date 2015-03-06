#!/bin/bash

SRC=bind-9.7.0-P2.tar.gz
DST=/var/spool/src/$SRC
MD5=47fc341901f00c1d815bef12ab4533de

[ -s "$DST" ] || wget -O $DST ftp://ftp.isc.org/isc/bind9/9.7.0-P2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
