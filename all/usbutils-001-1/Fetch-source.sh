#!/bin/bash

SRC=usbutils-001.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://ftp.kernel.org/pub/linux/utils/usb/usbutils/$SRC || wget -O $DST http://ftp.sunet.se/pub/Linux/kernel.org/linux/utils/usb/usbutils/$SRC

