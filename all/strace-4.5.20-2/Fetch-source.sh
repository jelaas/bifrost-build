#!/bin/bash

SRC=strace-4.5.20.tar.bz2
DST=/var/spool/src/$SRC
MD5=64dfe10d9db0c1e34030891695ffca4b

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/strace/strace/4.5.20/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
