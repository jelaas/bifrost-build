#!/bin/bash

SRC=apr-util-1.5.3.tar.bz2
DST=/var/spool/src/$SRC
MD5=6f3417691c7a27090f36e7cf4d94b36e

[ -s "$DST" ] || wget -O $DST http://archive.apache.org/dist/apr/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/apr-util/apr-util-1.5.3.tar.bz2/6f3417691c7a27090f36e7cf4d94b36e/$SRC \
              || wget -O $DST http://distfiles.macports.org/apr-util/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
