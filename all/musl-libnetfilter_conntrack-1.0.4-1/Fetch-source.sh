#!/bin/bash

SRC=libnetfilter_conntrack-1.0.4.tar.bz2
DST=/var/spool/src/$SRC
MD5=18cf80c4b339a3285e78822dbd4f08d7

[ -s "$DST" ] || wget -O $DST http://www.netfilter.org/projects/libnetfilter_conntrack/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
