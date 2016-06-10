#!/bin/bash

VER=mcelog-1.0pre3
SRC=$VER.tar.bz2
DST=/var/spool/src/$SRC

if [ ! -s "$DST" ]; then
    pkg_install passwd-file-1 || exit 2
    pkg_install git-1.7.1-2 || exit 2
    pkg_install openssh-5.5p1-1 || exit 2
    cd /tmp
    rm -rf $VER
    /opt/git/bin/git clone git://git.kernel.org/pub/scm/utils/cpu/mce/mcelog.git $VER || exit 1
    cd $VER  || exit 1
    /opt/git/bin/git checkout RELEASE_1_0_PRE3 || exit 1
    cd /tmp
    tar czf $DST $VER
    rm -rf $VER
fi
