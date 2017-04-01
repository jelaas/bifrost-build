#!/bin/bash

VER=0.8.18
SRC=nodejs-"${VER}".tar.gz
DST=/var/spool/src/"${SRC}"

if [ ! -s "${DST}" ]; then
    pkg_install passwd-file-1 || exit 2
    pkg_install git-1.7.1-2 || exit 2
    pkg_install openssh-5.5p1-1 || exit 2
    cd /tmp
    rm -rf nodejs-"${VER}"
    /opt/git/bin/git clone --depth 1 git://github.com/joyent/node.git nodejs-"${VER}" || exit 1
    cd nodejs-"${VER}"
    /opt/git/bin/git checkout v"${VER}" || exit 1
    rm -rf .git
    cd /tmp
    tar czf "${DST}" nodejs-"${VER}"
    rm -rf nodejs-"${VER}"
fi
