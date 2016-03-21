#!/bin/bash

SRC=libpcap-1.1.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.tcpdump.org/release/$SRC \
              || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/$SRC \
              || wget -O $DST http://distro.ibiblio.org/zenwalk/source/l/libpcap/$SRC
