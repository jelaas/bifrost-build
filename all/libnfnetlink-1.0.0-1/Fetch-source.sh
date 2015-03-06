#!/bin/bash

SRC=libnfnetlink-1.0.0.tar.bz2
DST=/var/spool/src/$SRC
MD5=016fdec8389242615024c529acc1adb8

[ -s "$DST" ] || wget -O $DST http://www.netfilter.org/projects/libnfnetlink/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
