#!/bin/bash

SRC=vlock-1.4.tar.gz
DST=/var/spool/src/$SRC
MD5=e681cf1ae3ee0619b1183da401e3829b

[ -s "$DST" ] || wget -O $DST http://cthulhu.c3d2.de/~toidinamai/vlock/archive/$SRC \
              || wget -O $DST http://ftp.sunet.se/pub/os/Linux/distributions/bifrost/download/src/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
