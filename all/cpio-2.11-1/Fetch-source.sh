#!/bin/bash

SRC=cpio-2.11.tar.bz2
DST=/var/spool/src/$SRC
MD5=20fc912915c629e809f80b96b2e75d7d

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/cpio/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
