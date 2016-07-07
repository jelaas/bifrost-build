#!/bin/bash

SRCVER=zlib-1.2.8
PKG=musl-$SRCVER-2 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
CDIR=/var/tmp/src
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
# pkg_install dependency-1.1 || exit 1
pkg_install musl-1.1.15-1 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $CDIR; tar xf $SRC

#########
# Patch
cd $CDIR/$SRCVER
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
B-configure-2 --prefix=/opt/musl --static || exit 1
sed -i 's/-DPIC//g' Makefile
sed -i 's/-fPIC//g' Makefile

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make -j 3 libz.a || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"

mkdir -p $DST/opt/musl/lib
mkdir -p $DST/opt/musl/include
mkdir -p $DST/opt/musl/lib/pkgconfig

cp libz.a $DST/opt/musl/lib
cp zlib.h $DST/opt/musl/include
cp zconf.h $DST/opt/musl/include
cp zlib.pc $DST/opt/musl/lib/pkgconfig

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (file usr/bin/myprog | grep -qs "statically linked") || exit 1

#########
# Clean up
cd $DST
#rm -rf usr/share usr/lib/libz.so*
#[ -d bin ] && strip bin/*
#[ -d usr/bin ] && strip usr/bin/*

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$CDIR/$SRCVER"
pkg_uninstall
exit 0
