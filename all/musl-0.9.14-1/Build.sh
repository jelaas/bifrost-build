#!/bin/bash

SRCVER=musl-0.9.14
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
[ -f /var/spool/src/$SRCVER.tar.bz2 ] && SRC=/var/spool/src/$SRCVER.tar.bz2
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
pkg_install binutils-2.20.1-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC || exit 1

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
#patch -p0 < $PKGDIR/time_h.pat || exit 1

#########
# Configure
$PKGDIR/B-configure-1 --prefix=/opt/musl --bindir=/usr/bin --disable-shared|| exit 1
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
mkdir -p $DST/etc
echo /opt/musl/lib > $DST/etc/ld-musl-x86_64.path
echo /opt/musl/lib > $DST/etc/ld-musl-i386.path
echo /opt/musl/lib > $DST/etc/ld-musl-i486.path
echo /opt/musl/lib > $DST/etc/ld-musl-i586.path
echo /opt/musl/lib > $DST/etc/ld-musl-i686.path

cd $DST || exit 1
cp opt/musl/lib/musl-gcc.specs opt/musl/lib/musl-gcc.specs.orig
patch -p0 < $PKGDIR/musl-gcc.specs.pat || exit 1

echo :::::::::::
diff -u usr/bin/musl-gcc $PKGDIR/musl-gcc
echo :::::::::::
cp $PKGDIR/musl-gcc usr/bin/musl-gcc || exit 1

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
