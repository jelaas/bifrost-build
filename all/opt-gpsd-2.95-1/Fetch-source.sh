#!/bin/bash

SRC=gpsd-2.95.tar.gz
DST=/var/spool/src/$SRC
MD5=12535a9ed9fecf9ea2c5bdc9840da5ae

[ -s "$DST" ] || wget -O $DST http://www.mirrorservice.org/sites/downloads.sourceforge.net/g/gp/gpsd.berlios/$SRC \
              || wget -O $DST https://distfiles.macports.org/gpsd/$SRC \
              || wget -O $DST http://pkgs.fedoraproject.org/repo/pkgs/gpsd/gpsd-2.95.tar.gz/12535a9ed9fecf9ea2c5bdc9840da5ae/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
