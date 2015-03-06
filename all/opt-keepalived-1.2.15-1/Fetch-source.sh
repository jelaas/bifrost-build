#!/bin/bash

SRC=keepalived-1.2.15.tar.gz
DST=/var/spool/src/$SRC
MD5=d85fcb8e564ea03b0ca7b2357bf30c51

[ -s "$DST" ] || wget -O $DST http://www.keepalived.org/software/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
