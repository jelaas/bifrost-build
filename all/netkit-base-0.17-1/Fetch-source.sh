#!/bin/bash

SRC=netkit-base-0.17.tar.gz
DST=/var/spool/src/$SRC
MD5=1f0193358e92559ec0f598b09ccbc0ec

[ -s "$DST" ] || wget -O $DST ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
