#!/bin/bash

SRC=jansson-2.7.tar.gz
DST=/var/spool/src/$SRC
MD5=3a106a465bbb77637550b422f5b262ef

[ -s "$DST" ] || wget -O $DST http://www.digip.org/jansson/releases/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
