#!/bin/bash

VER=1.2
SRCVER=tarmd-$VER
PKG=tarmd-src-$VER-1 # with build version

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

# Compile against musl:
# pkg_install musl-1.1.3-1 || exit 2 
# export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src

#########
# Patch
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
#make install DESTDIR=$DST # --with-install-prefix may be an alternative

mkdir -p "$DST/var/spool/src" || exit 1
cd $DST || exit 1
cp -r $PKGDIR/tarmd $SRCVER || exit 1
tar cf $DST/var/spool/src/$SRCVER.tar $SRCVER || exit 1
rm -rf $SRCVER

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
# rm -rf usr/share usr/man
[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*
[ -d sbin ] && strip sbin/*
[ -d usr/sbin ] && strip usr/sbin/*

#########
# Make package
cd $DST || exit 1
tar czf /var/spool/pkg/$PKG.tar.gz ./var/spool/src/$SRCVER.tar

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
