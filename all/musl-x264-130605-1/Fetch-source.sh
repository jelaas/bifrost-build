#!/bin/bash

VER=x264-130605
SRC=$VER.tar.gz
DST=/var/spool/src/$SRC

if [ ! -s "$DST" ]; then
	pkg_install passwd-file-1 || exit 2
 	pkg_install git-1.7.1-2 || exit 2
  	pkg_install openssh-5.5p1-1 || exit 2
	cd /tmp
	rm -rf $VER
	/opt/git/bin/git clone git://git.videolan.org/x264.git $VER || exit 1
	cd $VER  || exit 1
	/opt/git/bin/git checkout a3ac64b8b467eea1264c0053022893bc84b2e9a2 || exit 1
	cd /tmp
 	tar czf $DST $VER
 	rm -rf $VER
fi

