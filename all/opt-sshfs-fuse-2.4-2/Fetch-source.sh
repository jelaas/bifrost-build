#!/bin/bash

SRC=sshfs-fuse-2.4.tar.gz
DST=/var/spool/src/$SRC
MD5=3c7c3647c52ce84d09486f1da3a3ce24

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/fuse/sshfs-fuse/2.4/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
