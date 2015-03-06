#!/bin/bash

SRC=bc-1.06.tar.gz
DST=/var/spool/src/$SRC
MD5=d44b5dddebd8a7a7309aea6c36fda117

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/bc/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
