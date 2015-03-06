#!/bin/bash

SRC=zlib-1.2.7.tar.bz2
DST=/var/spool/src/$SRC
MD5=2ab442d169156f34c379c968f3f482dd

[ -s "$DST" ] || wget -O $DST ftp://ftp.simplesystems.org/pub/libpng/png/src/history/zlib/$SRC      \
              || wget -O $DST http://distro.ibiblio.org/tinycorelinux/5.x/x86/release/src/zlib/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/zlib/zlib-1.2.7.tar.bz2/2ab442d169156f34c379c968f3f482dd/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
