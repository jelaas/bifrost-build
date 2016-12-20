#!/bin/bash

SRCVER=libtirpc-1.0.1
PKG=musl-$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
[ -f /var/spool/src/$SRCVER.tar.bz2 ] && SRC=/var/spool/src/$SRCVER.tar.bz2
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
# pkg_install dependency1-1 || exit 2
# pkg_install groff-1.21-1 || exit 2 # Needed to convert man-pages: see below
pkg_install musl-kernel-headers-4.5.0-1 || exit 2
pkg_install patch-2.7.1-1 || exit 2

# Compile against musl:
pkg_install musl-1.1.15-1 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
rm -f src/nis.h
patch -p1 < $PKGDIR/git.patch || exit 1
mkdir -p tirpc/sys || exit 1
cp -f $PKGDIR/queue.h tirpc/sys || exit 1

#########
# Configure
B-configure-3 --prefix=/opt/musl --disable-gssapi || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make V=1 || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Convert man-pages
cd $DST || exit 1
# for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf opt/musl/share
# rm -rf opt/musl/man
[ -d opt/musl/bin ] && strip opt/musl/bin/*
[ -d opt/musl/sbin ] && strip opt/musl/sbin/*
[ -d opt/musl/libexec ] && strip opt/musl/libexec/*

#########
# Make package
cd $DST || exit 1
mv opt/musl/include/tirpc/rpc opt/musl/include || exit 1
mv opt/musl/include/tirpc/netconfig.h opt/musl/include  || exit 1
mv opt/musl/include/tirpc/rpcsvc opt/musl/include  || exit 1
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
