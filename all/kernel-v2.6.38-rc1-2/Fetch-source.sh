#!/bin/bash

V=v2.6.38-rc1
VER=kernel-$V
SRC=kernel-$V.tar.gz
DST=/var/spool/src/$SRC

if [ ! -s "$DST" ]; then
    pkg_install passwd-file-1 || exit 1
    pkg_install git-1.7.1-2 || exit 1
    pkg_install openssh-5.5p1-1 || exit 1
    cd /tmp
    rm -rf $VER
    /opt/git/bin/git clone git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next-2.6.git $VER || exit 1
    cd $VER
    /opt/git/bin/git checkout $V || exit 1
    cd /tmp
    tar czf $DST $VER
    rm -rf $VER
fi
