#!/bin/bash

SRC=findutils-4.4.2.tar.gz
DST=/var/spool/src/$SRC
MD5=351cc4adb07d54877fa15f75fb77d39f

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/findutils/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
