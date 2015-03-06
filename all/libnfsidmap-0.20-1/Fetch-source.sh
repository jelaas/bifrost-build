#!/bin/bash

SRC=libnfsidmap-0.20.tar.gz
DST=/var/spool/src/$SRC
MD5=9233cb77876eb642374a0d2bcaba1170

[ -s "$DST" ] || wget -O $DST http://www.citi.umich.edu/projects/nfsv4/linux/libnfsidmap/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
