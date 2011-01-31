#!/bin/bash

SRC=usbutils-001.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.kernel.org/pub/linux/utils/usb/usbutils/$SRC

