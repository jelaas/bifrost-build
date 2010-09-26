#!/bin/bash

V=2.0.2-rc2
VER=kexec-tools-$V
SRC=kexec-tools-$V.tar.gz
DST=/var/spool/src/$SRC

if [ ! -s "$DST" ]; then
    pkg_install passwd-file-1 || exit 1
    pkg_install git-1.7.1-2 || exit 1
    pkg_install openssh-5.5p1-1 || exit 1
    cd /tmp
    rm -rf $VER
    /opt/git/bin/git clone git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git $VER || exit 1
    cd $VER
    /opt/git/bin/git checkout ab82e4fc013a0293d016768fd9e28ede8b775675
    cd /tmp
    tar czf $DST $VER
    rm -rf $VER
fi
