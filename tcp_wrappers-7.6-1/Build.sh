#!/bin/bash

SRCVER=tcp_wrappers-7.6
PKG=$SRCVER-1 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/$PKG}
SRC=/var/spool/src/tcp_wrappers_7.6.tar.gz
CDIR=/var/tmp/src
SRCDIR=$CDIR/tcp_wrappers_7.6
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
# pkg_install dependency-1.1 || exit 1

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $CDIR; tar xf $SRC

#########
# Patch
cd $SRCDIR
#libtool_fix-1
patch -p1 < $PKGDIR/tcp_wrappers.patch
patch -p1 < $PKGDIR/tcp_wrappers-10-uclibc.patch

#########
# Configure

#########
# Post configure patch
sed 's/-O /-Os -march=i586 /g' Makefile > /tmp/makefile.$$
cp -f /tmp/makefile.$$ Makefile; rm -f /tmp/makefile.$$

#########
# Compile
make REAL_DAEMON_DIR=/usr/sbin STYLE=-DPROCESS_OPTIONS linux || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p $DST/usr/lib
mkdir -p $DST/usr/include
cp tcpd.h     $DST/usr/include
cp libwrap.a  $DST/usr/lib

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (file usr/bin/myprog | grep -qs "statically linked") || exit 1

#########
# Clean up
cd $DST

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$SRCDIR"
pkg_uninstall
exit 0
