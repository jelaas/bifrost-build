#!/bin/bash

SRC=console-data-1999.08.29.tar.gz
DST=/var/spool/src/$SRC
MD5=b534787af0edaa73f608f518263f9334

[ -s "$DST" ] || wget -O $DST http://www.ibiblio.org/pub/Linux/system/keyboards/$SRC \
              || wget -O $DST ftp://metalab.unc.edu/pub/Linux/system/keyboards/$SRC  \
 || ../../wget-finder -O $DST $SRC:$MD5
