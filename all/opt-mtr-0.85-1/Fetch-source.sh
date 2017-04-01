#!/bin/bash

VER=0.85
SRC=mtr-"${VER}".tar.gz
DST=/var/spool/src/"${SRC}"

if [ ! -s "${DST}" ]; then
    pkg_install passwd-file-1 || exit 2
    pkg_install git-1.7.1-2 || exit 2
    pkg_install openssh-5.5p1-1 || exit 2
    cd /tmp
    /opt/git/bin/git clone --depth 1 git://github.com/traviscross/mtr.git mtr-"${VER}" || exit 1
    cd mtr-"${VER}" || exit 1
    /opt/git/bin/git checkout v"${VER}" || exit 1
    rm -rf .git
    cd /tmp
    tar czf "${DST}" mtr-"${VER}"
    rm -rf mtr-"${VER}"
fi

