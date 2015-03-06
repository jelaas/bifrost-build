#!/bin/bash

V=4.1-ESV-R6
SRC=dhcp-$V.tar.gz
DST=/var/spool/src/$SRC
MD5=5a228dc9bf49649d49c91a5bed272963

[ -s "$DST" ] || wget -O $DST http://ftp.isc.org/isc/dhcp/$V/$SRC \
              || wget -O $DST http://ftp.isc.org/isc/dhcp/$SRC    \
 || ../../wget-finder -O $DST $SRC:$MD5
