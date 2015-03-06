#!/bin/bash

SRC=socat-1.7.2.2.tar.gz
DST=/var/spool/src/$SRC
MD5=fe70c821a104378a834c3ed1b5971e54

[ -s "$DST" ] || wget -O $DST http://www.dest-unreach.org/socat/download/Archive/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/socat/socat-1.7.2.2.tar.gz/fe70c821a104378a834c3ed1b5971e54/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
