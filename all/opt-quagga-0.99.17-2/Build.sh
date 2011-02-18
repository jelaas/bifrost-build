#!/bin/bash

SRCVER=quagga-0.99.17
PKG=opt-quagga-0.99.17-2 # with build version

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
# pkg_install dependency1-1 || exit 1
pkg_install gawk-3.1.8-1 || exit 2
pkg_install ncurses-lib-5.7-1 || exit 2
pkg_install readline-6.1-1 || exit 2
pkg_install perl-5.10.1-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
B-configure-1 --prefix=/opt/quagga --disable-shared --enable-irdp --enable-static=no --enable-rtadv \
 --enable-vtysh \
 --enable-user=root --enable-group=root --enable-multipath=6 --localstatedir=/var/run \
 --disable-capabilities --disable-doc --disable-pie --enable-ipv6 || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make -j 3 || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative
mkdir -p $DST/opt/quagga/etc/config.flags
mkdir -p $DST/opt/quagga/rc.d
echo yes > $DST/opt/quagga/etc/config.flags/quagga
cp -p $PKGDIR/rc.quagga $DST/opt/quagga/rc.d
cp -p $PKGDIR/README $DST/opt/quagga

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/quagga/sbin/zebra|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf opt/quagga/include opt/quagga/lib
strip opt/quagga/sbin/*
strip opt/quagga/bin/*

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
