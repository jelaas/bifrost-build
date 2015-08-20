#!/bin/bash

SRC=console-tools-0.2.3.tar.gz
DST=/var/spool/src/$SRC
MD5=983d4586a791b3fdfa0fbeff76aadf43

[ -s "$DST" ] || wget -O $DST http://www.ibiblio.org/pub/Linux/system/keyboards/$SRC \
              || wget -O $DST ftp://metalab.unc.edu/pub/Linux/system/keyboards/$SRC  \
 || ../../wget-finder -O $DST $SRC:$MD5
