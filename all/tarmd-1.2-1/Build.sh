#!/bin/bash

SRCVER=tarmd-1.2
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar
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
./Fetch-source.sh || exit $?
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 2
# pkg_install groff-1.21-1 || exit 2 # Needed to convert man-pages: see below

pkg_install musl-zlib-1.2.8-2 || exit 2
pkg_install musl-xz-5.2.2-1 || exit 2
pkg_install musl-bzip2-lib-1.0.6-3 || exit 2
pkg_install tarmd-src-1.2-1 || exit 2

# Compile against musl:
pkg_install musl-1.1.15-1 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
CFLAGS="-Wall -DUSE_ZLIB -DUSE_BZIP2 -DUSE_XZ -std=c99 -D_GNU_SOURCE" LDLIBS="-lz -llzma -lbz2" LDFLAGS="-static" make -e || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p "$DST" || exit 1
mkdir -p "$DST/usr/bin" || exit 1
strip tarmd
cp tarmd $DST/usr/bin || exit 1

#########
# Convert man-pages
cd $DST || exit 1
# for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
# rm -rf opt/musl/share
# rm -rf opt/musl/man
[ -d opt/musl/bin ] && strip opt/musl/bin/*
[ -d opt/musl/sbin ] && strip opt/musl/sbin/*
[ -d opt/musl/libexec ] && strip opt/musl/libexec/*

#########
# Make package
cd $DST || exit 1
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
