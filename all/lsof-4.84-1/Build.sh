#!/bin/bash

SRCVER=lsof_4.84
PKG=lsof-4.84-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/$PKG}
SRC=/var/spool/src/$SRCVER.tar.bz2
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

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 1

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC
echo $BUILDDIR
cd $BUILDDIR || exit 1
tar xf ${SRCVER}_src.tar

#########
# Patch
cd $BUILDDIR/${SRCVER}_src
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
yes |  ./Configure  linux
#sedit  "s/-O/-Os -static -march=i586/"  Makefile

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make DEBUG='' CDEF="-Os -march=i586" CFGL="-static -L./lib -llsof" || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p $DST/bin
cp lsof $DST/bin

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
strip bin/*

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
