#!/bin/bash

SRC=dtn-2.8.0.tgz
DST=/var/spool/src/$SRC
MD5=e9f65aa5f90e07ae50315b2f490f461c

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/dtn/DTN2/dtn-2.8.0/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
