#!/bin/bash

SRC=gawk-3.1.8.tar.gz
DST=/var/spool/src/$SRC
MD5=35937a0f83f0efe7a8c2dee635624784

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/gawk/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
