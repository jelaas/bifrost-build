#!/bin/bash

SRC=pciutils-3.1.7.tar.gz
DST=/var/spool/src/$SRC
MD5=f3e349d22a3714b4272b171649ad5235

[ -s "$DST" ] || wget -O $DST ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
