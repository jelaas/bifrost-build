#!/bin/bash

SRC=dnsmasq-2.52.tar.gz
DST=/var/spool/src/$SRC
MD5=1bb32fffdb4f977ead607802b5d701d0

[ -s "$DST" ] || wget -O $DST http://www.thekelleys.org.uk/dnsmasq/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
