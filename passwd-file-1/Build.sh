#!/bin/bash

SRCVER=passwd-file
PKG=$SRCVER-1 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
# pkg_install dependency-1.1 || exit 1

#########
# Unpack sources into dir under /var/tmp/src

#########
# Patch

#########
# Configure

#########
# Post configure patch

#########
# Compile

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p $DST/etc
cp -p $PKGDIR/passwd $DST/etc

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (file usr/bin/myprog | grep -qs "statically linked") || exit 1

#########
# Clean up
cd $DST

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
pkg_uninstall
exit 0
