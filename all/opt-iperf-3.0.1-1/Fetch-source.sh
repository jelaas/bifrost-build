#!/bin/bash

SRC=iperf-3.0.1.tar.gz
DST=/var/spool/src/$SRC
MD5=1bb10c8144460f1b7ce9a4bba55d8dcd

[ -s "$DST" ] || wget -O $DST http://stats.es.net/software/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
