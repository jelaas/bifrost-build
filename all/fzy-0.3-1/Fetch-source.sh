#!/bin/bash

VER=0.3
PROGNAME=fzy
SRC=$PROGNAME-$VER.tar.gz
DST=/var/spool/src/$SRC
MD5=2a0c15d51f68d6f5bd05e8129b651264

pkg_install wget-1.15-1 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://github.com/jhawthorn/$PROGNAME/archive/$VER.tar.gz \
 || ../../wget-finder -O $DST $SRC:$MD5
