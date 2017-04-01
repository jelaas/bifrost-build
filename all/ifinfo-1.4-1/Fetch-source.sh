#!/bin/bash

V=1.4
VER=ifinfo-"${V}"
SRC=ifinfo-"${V}".tar.gz
DST=/var/spool/src/"${SRC}"

if [ ! -s "${DST}" ]; then
    pkg_install passwd-file-1 || exit 1
    pkg_install git-1.7.1-2 || exit 1
    pkg_install openssh-5.5p1-1 || exit 1
    cd /tmp
    rm -rf "${VER}"
    /opt/git/bin/git clone git://github.com/jelaas/ifinfo.git "${VER}" || exit 1
    cd "${VER}"
    /opt/git/bin/git checkout "${V}" || exit 1
    cd /tmp
    tar czf "${DST}" "${VER}"
    rm -rf "${VER}"
fi

