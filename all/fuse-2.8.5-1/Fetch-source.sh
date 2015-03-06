#!/bin/bash

SRC=fuse-2.8.5.tar.gz
DST=/var/spool/src/$SRC
MD5=8aa2fd689de00b73963620483084ae3b

[ -s "$DST" ] || wget -O $DST http://ignum2.dl.sourceforge.net/project/fuse/fuse-2.X/2.8.5/fuse-2.8.5.tar.gz \
              || wget -O $DST http://garr.dl.sourceforge.net/project/fuse/fuse-2.X/2.8.5/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
