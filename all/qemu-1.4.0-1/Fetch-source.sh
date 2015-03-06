#!/bin/bash

SRC=qemu-1.4.0.tar.bz2
DST=/var/spool/src/$SRC
MD5=78f13b774814b6b7ebcaf4f9b9204318

[ -s "$DST" ] || wget -O $DST http://wiki.qemu-project.org/download/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
