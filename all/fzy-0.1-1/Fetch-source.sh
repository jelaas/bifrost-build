#!/bin/bash

VER=0.1
PROGNAME=fzy
SRC=$PROGNAME-$VER.tar.gz
DST=/var/spool/src/$SRC
MD5=073dfedc7700b02978f52b465d0223e1

pkg_install wget-1.15-1 || exit 2

[ -s "$DST" ] || wget --no-check-certificate -O $DST https://github.com/jhawthorn/$PROGNAME/archive/$VER.tar.gz \
 || ../../wget-finder -O $DST $SRC:$MD5
