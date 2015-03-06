#!/bin/bash

SRC=usbutils-001.tar.bz2
DST=/var/spool/src/$SRC
MD5=40398698053f9f735550117322430e57

[ -s "$DST" ] || wget -O $DST http://mirror.linux.org.au/linux/utils/usb/usbutils/$SRC \
              || wget -O $DST ftp://ftp.kernel.org/pub/linux/utils/usb/usbutils/$SRC   \
              || wget -O $DST http://ftp.sunet.se/pub/Linux/kernel.org/linux/utils/usb/usbutils/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
