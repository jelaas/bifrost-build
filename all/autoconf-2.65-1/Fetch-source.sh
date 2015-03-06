#!/bin/bash

SRC=autoconf-2.65.tar.gz
DST=/var/spool/src/$SRC
MD5=46cfb40e0babf4c64f8325f03da81c9b

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/autoconf/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
