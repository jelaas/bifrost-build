#!/bin/bash

SRC=dhcp-4.1.1.tar.gz
DST=/var/spool/src/$SRC
MD5=38a74c89d8913b9b5f33737047623c18

[ -s "$DST" ] || wget -O $DST ftp://ftp.isc.org/isc/dhcp/$SRC \
              || wget -O $DST ftp://ftp.isc.org/isc/dhcp/dhcp-4.1-history/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
