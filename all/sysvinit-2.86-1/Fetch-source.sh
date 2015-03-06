#!/bin/bash

SRC=sysvinit-2.86.tar.gz
DST=/var/spool/src/$SRC
MD5=7d5d61c026122ab791ac04c8a84db967

[ -s "$DST" ] || wget -O $DST http://ftp.sunet.se/pub/Linux/distributions/rootlinux/ports/base/sysvinit/$SRC \
              || wget -O $DST ftp://ftp.cistron.nl/pub/people/miquels/software/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
