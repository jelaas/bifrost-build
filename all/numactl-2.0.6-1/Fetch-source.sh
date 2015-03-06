#!/bin/bash

SRC=numactl-2.0.6.tar.gz
DST=/var/spool/src/$SRC
MD5=e84a6351312ec786a4b7978fea76f92b

[ -s "$DST" ] || wget -O $DST ftp://oss.sgi.com/www/projects/libnuma/download/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
