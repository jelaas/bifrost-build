#!/bin/bash

SRCVER=quagga-0.99.9
PKG=opt-quagga-0.99.9-1 # with build version

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
pkg_install automake-1.10-1 || exit 2
pkg_install perl-5.10.1-1 || exit 2
pkg_install autoconf-2.61-1 || exit 2
pkg_install m4-1.4.14-1 || exit 2

# Remove old
rm -r $BUILDDIR

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
patch -p1 < $PKGDIR/mypatch.pat || exit 1
patch -p1 < $PKGDIR/bfdd-0.90.1-quagga-0.99.9.patch || exit 1
patch -p1 < $PKGDIR/bfdd-0.90.1-bgp-quagga-0.99.9.patch || exit 1
patch -p0 < $PKGDIR/bfdd.pat || exit 1
# For bfdd
#autoreconf
#./update-autotools
automake
autoconf

#########
# Configure
B-configure-1 --prefix=/opt/quagga --disable-shared --enable-irdp --enable-static=no --enable-rtadv \
 --disable-vtysh \
 --enable-user=root --enable-group=root --enable-multipath=6 --localstatedir=/var/run \
 --disable-capabilities --disable-doc --disable-pie --enable-ipv6 || exit 1

echo true > missing 

grep BFD config.log | tail -2 >> bfdd/bfdd.h

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
cp -p $PKGDIR/README.bfd $DST/opt/quagga

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/quagga/sbin/zebra|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf opt/quagga/include opt/quagga/lib
strip opt/quagga/sbin/*
strip opt/quagga/bin/*

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
