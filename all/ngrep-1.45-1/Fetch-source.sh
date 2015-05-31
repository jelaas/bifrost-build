#!/bin/bash

SRC=ngrep-1.45.tar.bz2
DST=/var/spool/src/$SRC
MD5=bc8150331601f3b869549c94866b4f1c

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/ngrep/ngrep/1.45/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
