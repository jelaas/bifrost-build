#!/bin/bash

SRCVER=binutils-2.20.1
PKG=opt-$SRCVER-1 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.bz2
CDIR=/var/tmp/src
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
# pkg_install dependency-1.1 || exit 1

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $CDIR; tar xf $SRC

#########
# Patch
cd $CDIR/$SRCVER
libtool_fix-1
patch -p0 < $PKGDIR/bfd-makefile_in.pat

#########
# Configure
mkdir  buildit
cd     buildit || exit 1
PREFIX=opt/dev-x86_32
$PKGDIR/B-configure --prefix=/$PREFIX || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make -j || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (file usr/bin/myprog | grep -qs "statically linked") || exit 1

#########
# Clean up
cd $DST
rm -rf $PREFIX/share
rm -f $PREFIX/bin/nm
rm -f $PREFIX/bin/ar
rm -f $PREFIX/bin/strip
rm -f $PREFIX/bin/objcopy
rm -f $PREFIX/bin/ranlib
rm -f $PREFIX/bin/as
rm -f $PREFIX/bin/ld
rm -f $PREFIX/bin/objdump

strip $PREFIX/i686-pc-linux-gnu/bin/*
strip $PREFIX/bin/*

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz --hard-dereference .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$CDIR/$SRCVER"
pkg_uninstall
exit 0
