#!/bin/bash

SRC=smartmontools-5.43.tar.gz
DST=/var/spool/src/$SRC
MD5=a1cb2c3d8cc2de377037fe9e7cef40a9

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/smartmontools/smartmontools/5.43/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
