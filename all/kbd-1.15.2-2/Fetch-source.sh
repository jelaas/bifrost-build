#!/bin/bash

SRC=kbd-1.15.2.tar.gz
DST=/var/spool/src/$SRC
MD5=77d0b51454522bc6c170bbdc6e31202a

[ -s "$DST" ] || wget -O $DST ftp://ftp.altlinux.org/pub/people/legion/kbd/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
