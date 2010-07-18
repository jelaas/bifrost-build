#!/bin/bash

SRC=dhcp-4.1.1.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.isc.org/isc/dhcp/$SRC
