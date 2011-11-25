#!/bin/bash

V=3.0.0
VER=kernel-$V
SRC=kernel-$V.tar.gz
DST=/var/spool/src/$SRC

if [ ! -s "$DST" ]; then
    pkg_install passwd-file-1 || exit 2
    pkg_install git-1.7.1-2 || exit 2
    pkg_install openssh-5.5p1-1 || exit 2
    cd /tmp
    rm -rf $VER
    /opt/git/bin/git clone git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git $VER || exit 1
    cd $VER
    /opt/git/bin/git checkout 431bf99d26157d56689e5de65bd27ce9f077fc3f || exit 1
    rm -rf .git
    cd /tmp
    tar czf $DST $VER
    rm -rf $VER
fi
