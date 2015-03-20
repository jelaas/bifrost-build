#!/bin/bash

SRCVER=wget-1.15
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
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
pkg_install musl-zlib-1.2.8-1 || exit 2
pkg_install musl-openssl-1.0.1m-1 || exit 2
pkg_install musl-1.1.5-1 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat
sed -i 's/md4/md5/' configure

#########
# Configure
B-configure-3 --sysconfdir=/etc --prefix=/usr --bindir=/usr/bin \
 --disable-ntlm --with-ssl=openssl --with-libssl-prefix=/opt/musl || exit 1

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

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
(ldd usr/bin/wget|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf usr/share
[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*

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
