#!/bin/bash

SRC=argus-clients-3.0.6.tar.gz
DST=/var/spool/src/$SRC
MD5=f6289cbe33eb78818a6a7eef3b7f5662

[ -s "$DST" ] || wget -O $DST http://qosient.com/argus/src/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
