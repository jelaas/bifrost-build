#!/bin/bash

SRC=argus-3.0.6.tar.gz
DST=/var/spool/src/$SRC
MD5=dbdf8f0c4807fa33dc02b3708987fb10

[ -s "$DST" ] || wget -O $DST http://qosient.com/argus/src/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
