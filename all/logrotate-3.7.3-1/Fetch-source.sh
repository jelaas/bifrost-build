#!/bin/bash

SRC=logrotate-3.7.3.tar.gz
DST=/var/spool/src/$SRC
MD5=266c48560ba588649f815a0c59edb488

[ -s "$DST" ] || wget -O $DST http://ibiblio.download.sourcemage.org/pub/linux/distributions/sourcemage/mirror/$SRC \
              || wget -O $DST http://dbg.download.sourcemage.org/mirror/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
