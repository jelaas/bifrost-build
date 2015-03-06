#!/bin/bash

SRC=traceroute-2.0.16.tar.gz
DST=/var/spool/src/$SRC
MD5=3e84c525cdb4184d64aacaf9225e6503

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/traceroute/traceroute/traceroute-2.0.16/$SRC \
              || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
