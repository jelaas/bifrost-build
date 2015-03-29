#!/bin/bash

SRC=openssl-0.9.8zf.tar.gz
DST=/var/spool/src/$SRC
MD5=c69a4a679233f7df189e1ad6659511ec

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC \
     || ../../wget-finder -O $DST $SRC:$MD5
