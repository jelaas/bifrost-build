#!/bin/bash

SRC=snort-2.9.2.2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.mirrorservice.org/sites/downloads.sourceforge.net/s/sn/snort.mirror/$SRC \
              || wget -O $DST http://ftp.devil-linux.org/pub/devel/sources/1.6/$SRC \
              || wget -O $DST http://ftp.psu.ac.th/pub/snort/$SRC

