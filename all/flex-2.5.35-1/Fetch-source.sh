#!/bin/bash

SRC=flex-2.5.35.tar.bz2
DST=/var/spool/src/$SRC
MD5=10714e50cea54dc7a227e3eddcd44d57

[ -s "$DST" ] || wget -O $DST http://switch.dl.sourceforge.net/project/flex/flex/flex-2.5.35/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
