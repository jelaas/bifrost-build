#!/bin/bash

SRC=bind-9.9.1-P2.tar.gz
DST=/var/spool/src/$SRC
MD5=5f2f9ec0f1f1c67beaada349cdac0c15

[ -s "$DST" ] || wget -O $DST ftp://ftp.isc.org/isc/bind9/9.9.1-P2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
