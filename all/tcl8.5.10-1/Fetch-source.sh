#!/bin/bash

SRC=tcl8.5.10-src.tar.gz
DST=/var/spool/src/$SRC
MD5=a08eaf8467c0631937067c1948dd326b

[ -s "$DST" ] || wget -O $DST http://prdownloads.sourceforge.net/tcl/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
