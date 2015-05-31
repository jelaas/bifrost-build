#!/bin/bash

V=4.1-ESV-R11
SRC=dhcp-$V.tar.gz
DST=/var/spool/src/$SRC
MD5=6f8da99b8757c4f6e1e7289ef9044a7a

[ -s "$DST" ] || wget -O $DST http://ftp.isc.org/isc/dhcp/$V/$SRC \
              || wget -O $DST http://ftp.isc.org/isc/dhcp/$SRC    \
 || ../../wget-finder -O $DST $SRC:$MD5
