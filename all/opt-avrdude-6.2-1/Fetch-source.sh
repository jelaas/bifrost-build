#!/bin/bash

SRC=avrdude-6.2.tar.gz
DST=/var/spool/src/$SRC
MD5=11eba11661713a43d371e4ff382d98c3

[ -s "$DST" ] || wget -O $DST http://nongnu.askapache.com/avrdude/$SRC \
              || wget -O $DST http://download.savannah.gnu.org/releases/avrdude/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
