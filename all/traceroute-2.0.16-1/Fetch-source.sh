#!/bin/bash

SRC=traceroute-2.0.16.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/bifrost/src/$SRC || wget -O $DST http://freefr.dl.sourceforge.net/project/traceroute/traceroute/traceroute-2.0.16/$SRC
