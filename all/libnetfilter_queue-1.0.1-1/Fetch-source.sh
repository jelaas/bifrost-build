#!/bin/bash

SRC=libnetfilter_queue-1.0.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=08b968cb2d36c24deb7f26a69f5d8602

[ -s "$DST" ] || wget -O $DST http://www.netfilter.org/projects/libnetfilter_queue/files/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
