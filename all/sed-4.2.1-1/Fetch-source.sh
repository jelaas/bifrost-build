#!/bin/bash

SRC=sed-4.2.1.tar.gz
DST=/var/spool/src/$SRC
MD5=f0fd4d7da574d4707e442285fd2d3b86

[ -s "$DST" ] || wget -O $DST ftp://ftp.sunet.se/pub/gnu/sed/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
