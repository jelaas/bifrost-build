#!/bin/bash

V=4.1-ESV-R11
SRC=dhcp-$V.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.isc.org/isc/dhcp/$V/$SRC || wget -O $DST http://ftp.isc.org/isc/dhcp/$SRC
