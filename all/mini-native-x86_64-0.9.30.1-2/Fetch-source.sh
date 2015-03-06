#!/bin/bash

SRC=mini-native-x86_64-0.9.30.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=266f0b9e52ab09f651fd2a079b4ca8d9

[ -s "$DST" ] || wget -O $DST http://uclibc.org/downloads/binaries/0.9.30.1/mini-native-x86_64.tar.bz2 \
 || ../../wget-finder -O $DST $SRC:$MD5
