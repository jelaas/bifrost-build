#!/bin/bash

V=v4.5
VER=ethtool-"${V}"
SRC=ethtool-"${V}".tar.gz
DST=/var/spool/src/"${SRC}"

if [ ! -s "${DST}" ]; then
    pkg_install passwd-file-1 || exit 2
    pkg_install git-2.7.2-2 || exit 2
    pkg_install openssh-5.5p1-1 || exit 2
    cd /tmp
    rm -rf "${VER}"
    git clone http://git.kernel.org/pub/scm/network/ethtool/ethtool.git "${VER}" || exit 1
    cd "${VER}"
    git checkout "${V}" || exit 1
    cd /tmp
    tar czf "${DST}" "${VER}"
    rm -rf "${VER}"
fi

