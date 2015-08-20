#!/bin/bash

SRC=util-linux-2.26.2.tar.gz
DST=/var/spool/src/$SRC
MD5=098e656beb5eb1308738da4b7ca82c20

[ -s "$DST" ] || wget -O $DST ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.26/$SRC \
              || wget -O $DST http://postfix.cdpa.nsysu.edu.tw/Unix/Kernel/linux/utils/util-linux/v2.26/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
