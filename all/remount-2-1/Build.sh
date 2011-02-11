#!/bin/bash

SRCVER=remount-2
PKG=$SRCVER-1 # with build version

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

pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

pkg_install dietlibc-0.32-1 || exit 2

mkdir -p $BUILDDIR
cp $PKGDIR/Makefile $BUILDDIR
cp $PKGDIR/remount.c $BUILDDIR

#########
# Compile
cd $BUILDDIR
PATH=/opt/diet/bin:$PATH make || exit 1
strip remount

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p $DST/sbin
cp remount $DST/sbin

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
