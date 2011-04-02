#!/bin/bash

SRCVER=iputils-s20100418
PKG=$SRCVER-2 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.bz2
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
pkg_available sysfsutils-2.1.0-1 openssl-0.9.8n-2
pkg_install sysfsutils-2.1.0-1 || exit 2
pkg_install openssl-0.9.8n-2 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
patch -p0 < $PKGDIR/ping6_c.pat

#########
# Configure
#B-configure-1 --prefix=/usr || exit 1
sedit 's/-O2/-Os -march=i586/g' Makefile
sedit 's/-lresolv//g' Makefile
sedit 's/LDLIBS=/LDLIBS=-static/g' Makefile

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile

make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p "$DST/sbin"
cp -p ipg ping ping6 tracepath tracepath6 traceroute6 arping rarpd rdisc tftpd clockdiff "$DST/sbin"

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
(ldd sbin/ping|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
# rm -rf usr/share usr/man
[ -d sbin ] && strip sbin/*

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
