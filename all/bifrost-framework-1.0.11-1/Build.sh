#!/bin/bash

SRCVER=bifrost-framework-1.0.11
PKG=$SRCVER-1 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
pkg_install coreutils-7.6-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit $?
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR

#########
# Configure
#########
# Post configure patch

#########
# Compile

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
./install.sh -d $DST

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
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
