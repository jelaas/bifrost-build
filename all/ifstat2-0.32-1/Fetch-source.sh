#!/bin/bash

V=0.32
VER=ifstat2-$V
SRC=ifstat2-$V.tar.gz
DST=/var/spool/src/$SRC

if [ ! -s "$DST" ]; then
    pkg_install passwd-file-1 || exit 2
    pkg_install git-2.7.2-2 || exit 2
    pkg_install openssh-6.1p1-3 || exit 2
    cd /tmp
    rm -rf $VER
    /bin/git clone git://github.com/jelaas/ifstat2.git $VER || exit 1
    cd $VER
    /bin/git checkout $V || exit 1
    rm -rf .git
    cd /tmp
    tar czf $DST $VER
    rm -rf $VER
fi

