#!/bin/bash

V=0.14
VER=libdaemon-$V
SRC=libdaemon-$V.tar.gz
DST=/var/spool/src/$SRC

if [ ! -s "$DST" ]; then
    pkg_install passwd-file-1 || exit 2
    pkg_install git-1.7.1-2 || exit 2
    pkg_install openssh-5.5p1-1 || exit 2
    cd /tmp
    rm -rf $VER
    /opt/git/bin/git clone git://git.0pointer.net/libdaemon.git $VER || exit 1
    cd $VER
    /opt/git/bin/git checkout v$V || exit 1
    cd /tmp
    tar czf $DST $VER
    rm -rf $VER
fi
