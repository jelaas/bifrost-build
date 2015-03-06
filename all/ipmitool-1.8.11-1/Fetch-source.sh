#!/bin/bash

SRC=ipmitool-1.8.11.tar.gz
DST=/var/spool/src/$SRC
MD5=0f9b4758c2b7e8a7bafc2ead113b4bc6

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/ipmitool/ipmitool/1.8.11/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
