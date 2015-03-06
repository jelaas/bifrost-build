#!/bin/bash

SRC=e2fsprogs-1.41.11.tar.gz
DST=/var/spool/src/$SRC
MD5=fb507a40c2706bc38306f150d069e345

[ -s "$DST" ] || wget -O $DST http://surfnet.dl.sourceforge.net/project/e2fsprogs/e2fsprogs/1.41.11/$SRC   \
              || wget -O $DST http://ftp.jaist.ac.jp/pub/sourceforge/e/e2/e2fsprogs/e2fsprogs/1.41.11/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/e2fsprogs/e2fsprogs-1.41.11.tar.gz/fb507a40c2706bc38306f150d069e345/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
