#!/bin/bash

SRC=mini-native-x86_64-0.9.30.1.tar.bz2
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://uclibc.org/downloads/binaries/0.9.30.1/mini-native-x86_64.tar.bz2
