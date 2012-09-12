#!/bin/bash

SRCVER=wpa_supplicant-1.0
PKG=opt-$SRCVER-1 # with build version

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
./Fetch-source.sh || exit $?
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
pkg_install openssl-0.9.8x-1 || exit 2
pkg_install readline-6.1-1 || exit 2
pkg_install ncurses-lib-5.7-1 || exit 2

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
cd $BUILDDIR/wpa_supplicant
cp $PKGDIR/config .config

#B-configure-1 --prefix=/opt/$PKG --localstatedir=/var || exit 1
#[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log


#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make V=1 BINDIR=/opt/wpa_supplicant/bin LIBDIR=/opt/wpa_supplicant/lib || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST BINDIR=/opt/wpa_supplicant/bin LIBDIR=/opt/wpa_supplicant/lib
OPTDIR=$DST/opt/wpa_supplicant
mkdir -p $OPTDIR/etc/config.flags
mkdir -p $OPTDIR/etc/config.data
mkdir -p $OPTDIR/rc.d
echo $PKG > $OPTDIR/etc/pkgversion
cp $PKGDIR/wpa_supplicant.conf $OPTDIR/etc/wpa_supplicant.conf.sample
cp $PKGDIR/psk.conf $OPTDIR/etc/psk.conf.sample
echo no > $OPTDIR/etc/config.flags/wpa_supplicant
cp -p $PKGDIR/rc.wpa_supplicant $OPTDIR/rc.d/rc.wpa_supplicant
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
# rm -rf usr/share usr/man
strip opt/wpa_supplicant/bin/*

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
