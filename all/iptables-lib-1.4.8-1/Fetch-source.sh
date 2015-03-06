#!/bin/bash

SRC=iptables-1.4.8.tar.bz2
DST=/var/spool/src/$SRC
MD5=697ed89f37af4473a5f6349ba2700f2d

[ -s "$DST" ] || wget -O $DST http://www.iptables.org/projects/iptables/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
