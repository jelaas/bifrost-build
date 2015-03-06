#!/bin/bash

SRC=avr-libc-1.8.0.tar.bz2
DST=/var/spool/src/$SRC
MD5=54c71798f24c96bab206be098062344f

[ -s "$DST" ] || wget -O $DST http://download.savannah.gnu.org/releases/avr-libc/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
