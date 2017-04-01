#!/bin/bash

V=1.0.33
VER=bifrost-framework-"${V}"
SRC=bifrost-framework-"${V}".tar.gz
DST=/var/spool/src/"${SRC}"
SHA=c28459f5171de383894e9ba905246eafce3222f15bec737d6555f4af4d70259c

pkg_install tarmd-1.2-1 || exit 2

if [ ! -s "${DST}" ]; then
    pkg_install passwd-file-1 || exit 2
    pkg_install git-1.7.1-2 || exit 2
    pkg_install openssh-5.5p1-1 || exit 2
    cd /tmp
    rm -rf "${VER}"
    /opt/git/bin/git clone git://github.com/jelaas/bifrost-framework.git "${VER}" || exit 1
    cd "${VER}"
    /opt/git/bin/git checkout "${V}" || exit 1
    rm -rf .git
    cd /tmp
    tarmd "${SHA}" "${DST}" tar czf - "${VER}" || exit 1
    rm -rf "${VER}"
fi

