#!/bin/bash

SRCVER=fake-libintl
PKG=$SRCVER-3 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Simple inplace edit with sed.
# Usage: sedit 's/find/replace/g' Filename
function sedit {
    sed "$1" $2 > /tmp/sedit.$$
    cp /tmp/sedit.$$ $2
    rm /tmp/sedit.$$
}

#########
# Fetch sources
./Fetch-source.sh || exit 1
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

mkdir -p $BUILDDIR
cd $BUILDDIR
cp $PKGDIR/dummy.c .
gcc -c dummy.c
ar cr libintl.a dummy.o

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p "$DST/usr/include"
mkdir -p "$DST/usr/lib"
cp $PKGDIR/libintl.h "$DST/usr/include"
cp $BUILDDIR/libintl.a "$DST/usr/lib"

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
