#!/bin/bash

SRC=oasys-1.5.0.tgz
DST=/var/spool/src/$SRC
MD5=69a0bb6428625dc3cb93c5e67afd70be

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/dtn/oasys/oasys-1.5.0/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
