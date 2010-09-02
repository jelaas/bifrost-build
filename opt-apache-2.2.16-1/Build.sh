#!/bin/bash

SRCVER=httpd-2.2.16
PKG=opt-apache-2.2.16-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/$PKG}
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
# pkg_available dependency1-1 dependency2-1
pkg_install zlib-1.2.5-1 || exit 1
pkg_install openssl-0.9.8n-2 || exit 1

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
B-configure-1 --prefix=/opt/apache --disable-nls --enable-static-support\
 --enable-modules=all --enable-ssl --enable-proxy --enable-proxy-connect\
 --enable-proxy-http --enable-proxy-ajp --enable-proxy-balancer --enable-cgi\
 --disable-shared --enable-static --sysconfdir=/opt/apache/etc\
 --localstatedir=/var || exit 1
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
mkdir -p $DST/opt/apache/etc/config.flags
mkdir -p $DST/opt/apache/rc.d
echo yes > $DST/opt/apache/etc/config.flags/httpd
cp -p $PKGDIR/rc $DST/opt/apache/rc.d/rc.httpd
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $DST/opt/apache

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf opt/apache/lib opt/apache/manual opt/apache/man\
 opt/apache/icons opt/apache/include var opt/apache/build
strip opt/apache/bin/*

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
