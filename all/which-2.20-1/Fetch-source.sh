#!/bin/bash

SRC=which-2.20.tar.gz
DST=/var/spool/src/$SRC
MD5=95be0501a466e515422cde4af46b2744

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/which/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
