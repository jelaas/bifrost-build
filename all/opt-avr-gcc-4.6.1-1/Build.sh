#!/bin/bash

VER=4.6.1
SRCAVER=gcc-core-$VER
PKG=opt-avr-gcc-$VER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRCA=/var/spool/src/$SRCAVER.tar.gz
[ -f /var/spool/src/$SRCAVER.tar.bz2 ] && SRCA=/var/spool/src/$SRCAVER.tar.bz2
BUILDDIR=/var/tmp/src/gcc-$VER
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
pkg_install gmp-4.3.2-1 || exit 2
pkg_install mpfr-2.4.2-1 || exit 2
pkg_install mpc-0.8.1-1 || exit 2
pkg_install gawk-3.1.8-1 || exit 2
pkg_install opt-avr-binutils-2.20.1-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRCA; tar xf $SRCB

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
mkdir build || exit 1
cd build || exit 1
export PATH="/opt/dev-avr/bin:$PATH"
$PKGDIR/B-configure-1 --build=i586-linux-uclibc --target=avr \
 --prefix=/opt/dev-avr --with-stage1-ldflags=-static --with-boot-ldflags=-static --disable-nls \
 --disable-libgomp  --disable-libssp --enable-languages=c || exit 1
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

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm opt/dev-avr/bin/avr-gcc-4.6.1
strip opt/dev-avr/libexec/gcc/avr/4.6.1/*
strip opt/dev-avr/bin/*

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
