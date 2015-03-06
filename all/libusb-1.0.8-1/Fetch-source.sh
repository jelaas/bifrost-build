#!/bin/bash

SRC=libusb-1.0.8.tar.bz2
DST=/var/spool/src/$SRC
MD5=37d34e6eaa69a4b645a19ff4ca63ceef

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-1.0.8/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
