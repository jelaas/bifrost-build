#!/bin/bash

SRC=ppp-2.4.5.tar.gz
DST=/var/spool/src/$SRC
MD5=4621bc56167b6953ec4071043fe0ec57

[ -s "$DST" ] || wget -O $DST ftp://ftp.samba.org/pub/ppp/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
