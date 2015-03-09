#!/bin/bash

SRC=pciutils-3.2.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/$SRC
