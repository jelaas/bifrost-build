#!/bin/bash

SRC=ncurses-5.7.tar.gz
DST=/var/spool/src/$SRC
MD5=cce05daf61a64501ef6cd8da1f727ec6

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/ncurses/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
