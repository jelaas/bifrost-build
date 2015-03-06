#!/bin/bash

SRC=autoconf-2.61.tar.gz
DST=/var/spool/src/$SRC
MD5=51f472f71a6a04850a0f0126bf594cdb

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/autoconf/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
