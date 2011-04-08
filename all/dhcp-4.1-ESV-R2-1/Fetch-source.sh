#!/bin/bash

SRC=dhcp-4.1-ESV-R2.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.isc.org/isc/dhcp/$SRC
