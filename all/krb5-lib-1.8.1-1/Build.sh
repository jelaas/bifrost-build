#!/bin/bash

SRCVER=krb5-1.8.1
PKG=krb5-lib-1.8.1-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/$PKG}
SRC=/var/spool/src/$SRCVER-signed.tar
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Simple inplace edit with sed.
# Usage: sedit 's/find/replace/g' Filename
function sedit {
    sed $1 $2 > /tmp/sedit.$$
    cp /tmp/sedit.$$ $2
    rm /tmp/sedit.$$
}

#########
# Install dependencies:
pkg_available e2fsprogs-lib-1.41.11-1 perl-5.10.1-1 bison-2.4.2-1 openssl-0.9.8n-2
pkg_install bison-2.4.2-1 || exit 1
pkg_install e2fsprogs-lib-1.41.11-1 || exit 1
pkg_install perl-5.10.1-1 || exit 1
pkg_install openssl-0.9.8n-2 || exit 1
pkg_install m4-1.4.14-1 || exit 1

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar xf $SRC
tar xf $SRCVER.tar.gz

#########
# Patch
cd $BUILDDIR/src

libtool_fix-1

#########
# Configure
$PKGDIR/B-configure-1 --prefix=/usr --disable-shared --enable-static --enable-dns-for-kdc --enable-dns-for-realm --localstatedir=/var || exit 1

#########
# Post configure patch
patch -p1 < $PKGDIR/kdc_Makefile.pat || exit 1
patch -p0 < $PKGDIR/slave_Makefile.pat || exit 1
patch -p0 < $PKGDIR/tests_create_Makefile.pat || exit 1
patch -p0 < $PKGDIR/tests_verify_Makefile.pat || exit 1

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf usr/man  var
rm -rf usr/sbin/* usr/bin/*

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

