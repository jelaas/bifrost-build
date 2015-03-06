#!/bin/bash

SRC=libpcap-1.6.2.tar.gz
DST=/var/spool/src/$SRC
MD5=5f14191c1a684a75532c739c2c4059fa

[ -s "$DST" ] || wget -O $DST http://www.tcpdump.org/release/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
