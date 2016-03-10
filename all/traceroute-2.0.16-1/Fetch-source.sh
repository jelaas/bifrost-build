#!/bin/bash

SRC=traceroute-2.0.16.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/traceroute/traceroute/traceroute-2.0.16/$SRC || wget -O $DST http://sunsite.icm.edu.pl/pub/Linux/distributions/bifrost/download/src/$SRC
