#!/bin/bash

SRC=pcre-8.37.tar.bz2
DST=/var/spool/src/$SRC
MD5=ed91be292cb01d21bc7e526816c26981

[ -s "$DST" ] || wget -O $DST ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/$SRC || \
    wget -O $DST http://downloads.sourceforge.net/project/pcre/pcre/8.02/$SRC || \
  ../../wget-finder -O $DST $SRC:$MD5
