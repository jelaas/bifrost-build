#!/bin/bash

V=1.0.7
VER=devtag-$V
SRC=devtag-$V.tar.gz
DST=/var/spool/src/$SRC

if [ ! -s "$DST" ]; then
    cd /tmp
    rm -rf $VER
    git clone git://github.com/jelaas/devtag.git $VER || exit 1
    cd $VER
    git checkout $V || exit 1
    cd /tmp
    tar czf $DST $VER
    rm -rf $VER
fi

