#!/bin/bash

SRC=gettext-0.18.1.1.tar.gz
DST=/var/spool/src/$SRC
MD5=3dd55b952826d2b32f51308f2f91aa89

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/gettext/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
