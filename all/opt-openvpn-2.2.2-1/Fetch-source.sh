#!/bin/bash

SRC=openvpn-2.2.2.tar.gz
DST=/var/spool/src/$SRC
MD5=c5181e27b7945fa6276d21873329c5c7

[ -s "$DST" ] || wget -O $DST http://swupdate.openvpn.org/community/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
