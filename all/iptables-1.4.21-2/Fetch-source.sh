#!/bin/bash

SRC=iptables-1.4.21.tar.bz2
DST=/var/spool/src/$SRC
MD5=536d048c8e8eeebcd9757d0863ebb0c0

[ -s "$DST" ] || wget -O $DST http://www.iptables.org/projects/iptables/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
