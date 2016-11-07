#!/bin/bash

SRC=usbutils-001.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/usbutils/usbutils-001.tar.gz/3ecdcb42f08ef0d63e2638feb06ececc/$SRC || wget -O $DST http://mirror.linux.org.au/linux/utils/usb/usbutils/$SRC || wget -O $DST http://sunsite.icm.edu.pl/pub/Linux/kernel.org/linux/utils/usb/usbutils/$SRC
