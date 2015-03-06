#!/bin/bash

SRC=samba-3.6.8.tar.gz
DST=/var/spool/src/$SRC
MD5=fbb245863eeef2fffe172df779a217be

[ -s "$DST" ] || wget -O $DST http://www.samba.org/samba/ftp/stable/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
