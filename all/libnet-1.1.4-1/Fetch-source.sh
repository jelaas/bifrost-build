#!/bin/bash

SRC=libnet-1.1.4.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://garr.dl.sourceforge.net/project/libnet-dev/libnet-dev/libnet-1.1.4/$SRC || wget -O $DST http://fastbull.dl.sourceforge.net/project/libnet-dev/libnet-dev/libnet-1.1.4/$SRC
