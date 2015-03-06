#!/bin/bash

SRC=daq-0.6.2.tar.gz
DST=/var/spool/src/$SRC
MD5=6ea8aaa6f067f8b8ef6de45b95d55875

[ -s "$DST" ] || wget -O $DST http://www.procyonlabs.com/mirrors/snort/$SRC \
              || wget -O http://ftp.psu.ac.th/pub/snort/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
