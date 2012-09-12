#!/bin/bash

SRCVER=gpsd-2.95
PKG=opt-gpsd-2.95-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
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
pkg_install Python-2.7-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
B-configure-1 --prefix=/opt/$PKG --localstatedir=/var || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
patch -p0 < $PKGDIR/gps.h.pat

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative
OPTDIR=$DST/opt/$PKG
mkdir -p $OPTDIR/etc/config.flags
mkdir -p $OPTDIR/rc.d
echo yes > $OPTDIR/etc/config.flags/example
echo $PKG > $OPTDIR/pkgversion
cp -p $PKGDIR/rc $OPTDIR/rc.d/rc.example
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf share man lib include 
rm -rf opt/opt-gpsd-2.95-1/include
rm -rf opt/opt-gpsd-2.95-1/man
rm -rf opt/opt-gpsd-2.95-1/lib
rm -rf opt/opt-gpsd-2.95-1/share

[ -d opt/opt-gpsd-2.95-1/bin ] && strip opt/opt-gpsd-2.95-1/bin/*
[ -d opt/opt-gpsd-2.95-1/sbin ] && strip opt/opt-gpsd-2.95-1/sbin/*

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
