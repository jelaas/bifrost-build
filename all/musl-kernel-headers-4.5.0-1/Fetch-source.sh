#!/bin/bash

V=4.5.0
VER=kernel-"${V}"
SRC=kernel-"${V}".tar.gz
DST=/var/spool/src/"${SRC}"

if [ ! -s "${DST}" ]; then
    pkg_install passwd-file-1 || exit 2
    pkg_install git-2.7.2-2 || exit 2
    pkg_install openssh-5.5p1-1 || exit 2
    cd /tmp
    rm -rf "${VER}"
    git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git "${VER}" || exit 1
    cd "${VER}"
    git checkout v4.5 || exit 1
    rm -rf .git
    cd /tmp
    tar czf "${DST}" "${VER}"
    rm -rf "${VER}"
fi
