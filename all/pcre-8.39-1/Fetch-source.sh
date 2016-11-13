#!/bin/bash

SRC=pcre-8.39.tar.bz2
DST=/var/spool/src/$SRC
SHA=32889f9533b8b95f36c6b6f72f82583896c838e5e538cf6e6ead6f630e5a4a57
MD5=e3fca7650a0556a2647821679d81f585

pkg_install tarmd-1.2-1 || exit 2
pkg_install wget-1.15-1 || exit 2
[ -s "$DST" ] || tarmd $SHA $DST /usr/bin/wget -O- ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/$SRC\
 || tarmd $SHA $DST /usr/bin/wget -O- http://downloads.sourceforge.net/project/pcre/pcre/8.39/pcre-8.39.tar.bz2\
 || ../../wget-finder -O $DST $SRC:$MD5
