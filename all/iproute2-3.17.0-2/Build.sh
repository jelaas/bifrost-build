#!/bin/bash

SRCVER=iproute2-3.17.0
PKG=$SRCVER-2 # with build version

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
pkg_available bison-2.4.2-1 m4-1.4.14-1 flex-2.5.35-1 # iptables-lib-1.4.8-1
pkg_install bison-2.4.2-1 || exit 2
pkg_install m4-1.4.14-1 || exit 2
pkg_install flex-2.5.35-1 || exit 2
pkg_install musl-iptables-lib-1.4.21-1 || exit 2
pkg_install musl-kernel-headers-3.17.0-1 || exit 2
pkg_install musl-pkg-config-0.23-1 || exit 2
pkg_install musl-1.1.8-1 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
patch -p1 < $PKGDIR/musl.pat || exit 1
sed -i 's,LIBDIR=$(PREFIX)/lib,LIBDIR=/lib,' Makefile

#########
# Configure
./configure || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
LDFLAGS="-static" SHARED_LIBS=n make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
SHARED_LIBS=n make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
for f in ip rtmon tc ss nstat ifstat rtacct lnstat genl; do
 if ! (ldd sbin/$f|grep -qs "not a dynamic executable"); then
	echo "$f is not a static executable"
 	exit 1
 fi
done

#########
# Clean up
cd $DST || exit 1
rm -rf usr/share var
rm -f sbin/rtstat
strip sbin/*

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

