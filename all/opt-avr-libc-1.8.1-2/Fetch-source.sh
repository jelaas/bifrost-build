#!/bin/bash

VER=r2494
SRC=avr-libc-$VER.tar.gz
DST=/var/spool/src/$SRC

if [ ! -s "$DST" ]; then
	pkg_install subversion-1.9.3-1 || exit 2
	cd /tmp || exit 1
	rm -rf avr-libc
	svn co svn://svn.savannah.nongnu.org/avr-libc/trunk@$VER avr-libc
	cd avr-libc || exit 1
	tar czf $DST avr-libc
fi
