#!/bin/bash

SRC=pkg-config-0.23.tar.gz
DST=/var/spool/src/$SRC
MD5=d922a88782b64441d06547632fd85744

[ -s "$DST" ] || wget -O $DST http://pkg-config.freedesktop.org/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
