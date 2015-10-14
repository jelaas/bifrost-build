#!/bin/bash

SRC=pwgen-2.07.tar.gz
DST=/var/spool/src/$SRC
MD5=910b1008cdd86445e9e01305d21ee4c5

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/pwgen/pwgen/2.07/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/pwgen/pwgen-2.07.tar.gz/910b1008cdd86445e9e01305d21ee4c5/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
