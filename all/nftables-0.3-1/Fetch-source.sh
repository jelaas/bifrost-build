#!/bin/bash

SRC=nftables-0.3.tar.bz2
DST=/var/spool/src/$SRC
MD5=244e449ee80bbbf2b2908d861b074c7f

[ -s "$DST" ] || wget -O $DST ftp://ftp.netfilter.org/pub/nftables/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
