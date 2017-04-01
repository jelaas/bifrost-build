#!/bin/bash

VER=x264-150119
SRC="${VER}".tar.gz
DST=/var/spool/src/"${SRC}"

if [ ! -s "${DST}" ]; then
	pkg_install passwd-file-1 || exit 2
	pkg_install git-1.7.1-2 || exit 2
	pkg_install openssh-5.5p1-1 || exit 2
	cd /tmp
	rm -rf "${VER}"
	/opt/git/bin/git clone git://git.videolan.org/x264.git "${VER}" || exit 1
	cd "${VER}"  || exit 1
	/opt/git/bin/git checkout 40bb56814e56ed342040bdbf30258aab39ee9e89 || exit 1
	cd /tmp
	tar czf "${DST}" "${VER}"
	rm -rf "${VER}"
fi

