#!/bin/bash

SRC=libnetfilter_conntrack-0.0.101.tar.bz2
DST=/var/spool/src/$SRC
MD5=3c4b4048c914f2694c3ca6de2bb457dc

[ -s "$DST" ] || wget -O $DST http://www.netfilter.org/projects/libnetfilter_conntrack/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
