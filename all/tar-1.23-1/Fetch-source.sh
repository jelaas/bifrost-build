#!/bin/bash

SRC=tar-1.23.tar.bz2
DST=/var/spool/src/$SRC
MD5=41e2ca4b924ec7860e51b43ad06cdb7e

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/tar/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
