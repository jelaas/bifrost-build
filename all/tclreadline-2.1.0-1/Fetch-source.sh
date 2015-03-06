#!/bin/bash

SRC=tclreadline-2.1.0.tar.gz
DST=/var/spool/src/$SRC
MD5=219d0247a1373578080940ebde53bdd0

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/tclreadline/tclreadline/tclreadline-2.1.0/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
