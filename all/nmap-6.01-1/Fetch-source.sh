#!/bin/bash

SRC=nmap-6.01.tar.bz2
DST=/var/spool/src/$SRC
MD5=a1a71940f238abb835dbf3ee7412bcea

[ -s "$DST" ] || wget -O $DST  http://nmap.org/dist/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
