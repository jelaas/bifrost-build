#!/bin/bash

SRCVER=bash-4.1
PKG=$SRCVER-1 # with build version

PKGDIR=/var/lib/build/$PKG
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
pkg_available readline-6.1-1 ncurses-5.7-1
pkg_install readline-6.1-1 || exit 1
pkg_install ncurses-5.7-1 || exit 1

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
B-configure-1 --prefix=/ --enable-static-link || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
echo '#define WCONTINUED_BROKEN 1' >> config.h
echo '#undef CAN_REDEFINE_GETENV' >> config.h

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
rm -rf share
rm -f bin/bashbug
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
