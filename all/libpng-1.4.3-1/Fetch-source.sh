#!/bin/bash

SRC=libpng-1.4.3.tar.bz2
DST=/var/spool/src/$SRC
MD5=9347eeda4241401f7da4dc9ba7f6a416

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/os/Linux/distributions/bifrost/old/src/$SRC  \
              || wget -O $DST ftp://ftp.simplesystems.org/pub/libpng/png/src/history/libpng14/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/mingw32-libpng/libpng-1.4.3.tar.bz2/9347eeda4241401f7da4dc9ba7f6a416/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
