#!/bin/bash

SRC=ipsec-tools-0.8.0.tar.bz2
DST=/var/spool/src/$SRC
MD5=b79aae3055a51f8de5c0f1b8ca6cf619

[ -s "$DST" ] || wget -O $DST http://sunet.dl.sourceforge.net/project/ipsec-tools/ipsec-tools/0.8.0/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
