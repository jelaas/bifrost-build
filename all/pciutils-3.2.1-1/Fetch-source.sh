#!/bin/bash

SRC=pciutils-3.2.1.tar.gz
DST=/var/spool/src/$SRC
MD5=fdc92c4665bb169022ffe730b3c08313

[ -s "$DST" ] || wget -O $DST ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
