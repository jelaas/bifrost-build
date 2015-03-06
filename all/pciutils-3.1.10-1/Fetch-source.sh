#!/bin/bash

SRC=pciutils-3.1.10.tar.gz
DST=/var/spool/src/$SRC
MD5=cdb1e5a95ab7ac67349f10c8f77a6d3c

[ -s "$DST" ] || wget -O $DST ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
