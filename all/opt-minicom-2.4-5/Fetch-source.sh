#!/bin/bash

SRC=minicom-2.4.tar.gz
DST=/var/spool/src/$SRC
MD5=700976a3c2dcc8bbd50ab9bb1c08837b

[ -s "$DST" ] || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/minicom/minicom-2.4.tar.gz/700976a3c2dcc8bbd50ab9bb1c08837b/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
