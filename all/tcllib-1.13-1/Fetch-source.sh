#!/bin/bash

SRC=tcllib-1.13.tar.bz2
DST=/var/spool/src/$SRC
MD5=4625574b88a65031ecf0a0fd7e33764d

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/tcllib/tcllib/1.13/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
