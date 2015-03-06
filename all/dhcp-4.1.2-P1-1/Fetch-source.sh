#!/bin/bash

SRC=dhcp-4.1.2-P1.tar.gz
DST=/var/spool/src/$SRC
MD5=7e02b70429cc327dac8e6057467192e4

[ -s "$DST" ] || wget -O $DST ftp://ftp.isc.org/isc/dhcp/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
