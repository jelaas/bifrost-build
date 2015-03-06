#!/bin/bash

SRC=sysklogd-1.4.1.tar.gz
DST=/var/spool/src/$SRC
MD5=d214aa40beabf7bdb0c9b3c64432c774

[ -s "$DST" ] || wget -O $DST http://shlrm.org/sourcemage/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
