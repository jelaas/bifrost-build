#!/bin/bash

SRC=avrdude-5.10.tar.gz
DST=/var/spool/src/$SRC
MD5=69b082683047e054348088fd63bad2ff

[ -s "$DST" ] || wget -O $DST http://nongnu.askapache.com/avrdude/$SRC \
              || wget -O $DST http://download.savannah.gnu.org/releases/avrdude/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
