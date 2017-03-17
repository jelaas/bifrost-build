#!/bin/bash

SRC=keepalived-1.3.2.tar.gz
DST=/var/spool/src/$SRC
MD5=744025d57c7f065c42fe925b0283897e

[ -s "$DST" ] || wget -O $DST http://www.keepalived.org/software/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
