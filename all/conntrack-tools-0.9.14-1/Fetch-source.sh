#!/bin/bash

SRC=conntrack-tools-0.9.14.tar.bz2
DST=/var/spool/src/$SRC
MD5=7e9344fe85bb68bcf65c35034add6655

[ -s "$DST" ] || wget -O $DST http://www.netfilter.org/projects/conntrack-tools/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
