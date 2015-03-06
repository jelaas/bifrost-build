#!/bin/bash

SRC=openvpn-2.3.5.tar.gz
DST=/var/spool/src/$SRC
MD5=4422fe0b6ba898a4df6411fe3cc2d2f8

[ -s "$DST" ] || wget -O $DST http://swupdate.openvpn.org/community/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
