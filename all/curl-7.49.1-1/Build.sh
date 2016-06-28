#!/bin/bash

SRCVER=curl-7.49.1
PKG=$SRCVER-1 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.bz2
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"
MBEDSSLSRC=$PKGDIR/mbedtls-2.2.1-apache.tgz
MBEDBUILDDIR=/var/tmp/src/mbedtls-2.2.1

#########
# Install dependencies:

#########
# Unpack sources into dir under /var/tmp/src

cd $(dirname $BUILDDIR) || exit 1
tar xf $SRC
tar xf $MBEDSSLSRC

cd $MBEDBUILDDIR || exit 1
make no_test || exit 1
echo MBED SSL built
make install DESTDIR=$MBEDBUILDDIR/install
ln -s $MBEDBUILDDIR/install/include/mbedtls $MBEDBUILDDIR/install/include/openssl
ln -s $MBEDBUILDDIR/install/lib/libmbedcrypto.a $MBEDBUILDDIR/install/lib/libcrypto.a
ln -s $MBEDBUILDDIR/install/lib/libmbedtls.a $MBEDBUILDDIR/install/lib/libssl.a
ln -s $MBEDBUILDDIR/install/include/mbedtls/error.h $MBEDBUILDDIR/install/include/mbedtls/err.h

#########
# Patch
cd $BUILDDIR
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure

$PKGDIR/B-configure-1 --prefix=/usr --without-ca-bundle --with-mbedtls=$MBEDBUILDDIR/install || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make -j || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (file usr/bin/myprog | grep -qs "statically linked") || exit 1

#########
# Clean up
cd $DST
rm -rf usr/share usr/include usr/lib
rm usr/bin/curl-config
#[ -d bin ] && strip bin/*
strip usr/bin/*

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR" "$MBEDBUILDDIR"
pkg_uninstall
exit 0
