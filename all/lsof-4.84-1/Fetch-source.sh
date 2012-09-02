#!/bin/bash

SRC=lsof_4.84.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/OLD/$SRC || wget -O $DST ftp://ftp.fu-berlin.de/pub/unix/tools/lsof/OLD/$SRC || wget -O $DST ftp://ftp.fu-berlin.de/pub/unix/tools/lsof/$SRC || wget -O $DST ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/$SRC
