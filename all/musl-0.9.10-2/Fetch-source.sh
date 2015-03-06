#!/bin/bash

SRC=musl-0.9.10.tar.gz
DST=/var/spool/src/$SRC
MD5=8998be253b6f0880a1ce00d85dbae9c5

[ -s "$DST" ] || wget -O $DST http://www.etalabs.net/musl/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
