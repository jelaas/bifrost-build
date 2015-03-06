#!/bin/bash

SRC=pciutils-3.1.9.tar.gz
DST=/var/spool/src/$SRC
MD5=e958f5ffb93b12972964381c38f27eb3

[ -s "$DST" ] || wget -O $DST ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
