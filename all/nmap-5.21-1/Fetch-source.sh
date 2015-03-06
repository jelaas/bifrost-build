#!/bin/bash

SRC=nmap-5.21.tar.bz2
DST=/var/spool/src/$SRC
MD5=f77fa51d89ab27d35e5cd87bb086b858

[ -s "$DST" ] || wget -O $DST  http://nmap.org/dist/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
