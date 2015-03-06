#!/bin/bash

SRC=sysstat-9.0.6.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=2f9c5f53480215c11a6489b5c3ce6c39

[ -s "$DST" ] || wget -O $DST http://sebastien.godard.pagesperso-orange.fr/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
