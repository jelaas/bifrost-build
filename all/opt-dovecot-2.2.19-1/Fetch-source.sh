#!/bin/bash

SRC=dovecot-2.2.19.tar.gz
DST=/var/spool/src/$SRC
MD5=95591b6556413edc2f0b160fb469d04c

[ -s "$DST" ] || wget -O $DST http://www.dovecot.org/releases/2.2/$SRC     \
              || wget -O $DST https://distfiles.macports.org/dovecot2/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
