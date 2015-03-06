#!/bin/bash

SRC=parted-3.1.tar.xz
DST=/var/spool/src/$SRC
MD5=5d89d64d94bcfefa9ce8f59f4b81bdcb

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/parted/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
