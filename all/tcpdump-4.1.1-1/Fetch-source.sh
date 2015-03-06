#!/bin/bash

SRC=tcpdump-4.1.1.tar.gz
DST=/var/spool/src/$SRC
MD5=d0dd58bbd6cd36795e05c6f1f74420b0

[ -s "$DST" ] || wget -O $DST http://www.tcpdump.org/release/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
