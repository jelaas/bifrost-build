#!/bin/bash

SRC=dhcpcd-4.0.15.tar.bz2
DST=/var/spool/src/$SRC
MD5=76214893af7427a8e6f204b055b776a6

[ -s "$DST" ] || wget -O $DST http://roy.marples.name/downloads/dhcpcd/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
