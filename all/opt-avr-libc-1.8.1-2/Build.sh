#!/bin/bash

SRCVER=avr-libc-1.8.1
PKG=opt-$SRCVER-2 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/avr-libc-r2494.tar.gz
BUILDDIR=/var/tmp/src/avr-libc
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
# pkg_install musl-0.9.9-2 || exit 2 
# export CC=musl-gcc
pkg_install opt-avr-binutils-2.25.1-1 || exit 2
pkg_install opt-avr-gcc-5.3.0-1 || exit 2
pkg_install autoconf-2.69-1 || exit 2
pkg_install automake-1.14.1-1 || exit 2
pkg_install m4-1.4.17-1 || exit 2
pkg_install perl-5.10.1-3 || exit 2
export PATH=/opt/dev-avr/bin:$PATH
export CC=avr-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
echo $BUILDDIR
./bootstrap
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
OPTPREFIX=opt/dev-avr
mkdir -p build || exit 1
cd build || exit 1
$PKGDIR/B-configure-3 --build=$(../config.guess) --prefix=/$OPTPREFIX --localstatedir=/var --host=avr --enable-device-lib || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative
OPTDIR=$DST/$OPTPREFIX
echo $PKG > $OPTDIR/pkgversion.avr-libc

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
[ -d $OPTPREFIX/bin ] && strip $OPTPREFIX/bin/*
[ -d $OPTPREFIX/sbin ] && strip $OPTPREFIX/sbin/*
[ -d $OPTPREFIX/usr/bin ] && strip $OPTPREFIX/usr/bin/*

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
