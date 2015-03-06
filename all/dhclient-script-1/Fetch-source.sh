#!/bin/bash

SRC=dhcp-4.1-ESV-R2.tar.gz
DST=/var/spool/src/$SRC
MD5=70ff4cc73b9110f65218858fa7ae4f6f

[ -s "$DST" ] || wget -O $DST http://ftp.isc.org/isc/dhcp/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
