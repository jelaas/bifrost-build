#!/bin/bash

SRCVER=sysvinit-2.86
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Simple inplace edit with sed.
# Usage: sedit 's/find/replace/g' Filename
function sedit {
    sed $1 $2 > /tmp/sedit.$$
    cp /tmp/sedit.$$ $2
    rm /tmp/sedit.$$
}

#########
# Install dependencies:
pkg_available passwd-file-1 group-file-1
pkg_install passwd-file-1 || exit 1
pkg_install group-file-1 || exit 1

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
patch -p1 < $PKGDIR/sysvinit-2.86-bifrost.pat

#########
# Configure
# B-configure-1 --prefix=/usr || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
cd src
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p $DST/bin
mkdir -p $DST/usr/bin
mkdir -p $DST/usr/include
mkdir -p $DST/usr/share/man/man1
mkdir -p $DST/usr/share/man/man5
mkdir -p $DST/usr/share/man/man8
mkdir -p $DST/sbin
make install ROOT=$DST || exit 1

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf usr/share usr/include
[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
