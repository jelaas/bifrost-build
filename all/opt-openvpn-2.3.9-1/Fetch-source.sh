#!/bin/bash

SRC=openvpn-2.3.9.tar.gz
DST=/var/spool/src/$SRC
MD5=265755044ae88f9249d509f6d061f7e5

[ -s "$DST" ] || wget -O $DST http://swupdate.openvpn.org/community/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
