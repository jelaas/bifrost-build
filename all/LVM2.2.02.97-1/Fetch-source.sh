#!/bin/bash

SRC=LVM2.2.02.97.tgz
DST=/var/spool/src/$SRC
MD5=d18bd01334309db1c422b9bf6b181057

[ -s "$DST" ] || wget -O $DST ftp://sources.redhat.com/pub/lvm2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
