#!/bin/bash

SRCVER=alpine-2.10
PKG=opt-$SRCVER-1 # with build version
# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.clean.tar.lzma
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
pkg_install shadow-file-1 || exit 2
pkg_install xz-5.0.3-1 || exit 2
pkg_install ncurses-lib-5.7-1 || exit 2
pkg_install openssl-1.0.1c-1 || exit 2

# pkg_install groff-1.21-1 || exit 2 # Needed to convert man-pages: see below

# Compile against musl:
# pkg_install musl-0.9.1-1 || exit 2 
# export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC || exit 1

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
OPTPREFIX=opt/alpine
B-configure-1 --prefix=/$OPTPREFIX --localstatedir=/var || exit 1
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
OPTDIR=$DST/$OPTPREFIX
echo $PKG > $OPTDIR/pkgversion
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR

#########
# Convert man-pages
cd $DST || exit 1
# for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd ./opt/alpine/bin/alpine|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf opt/alpine/share ./opt/alpine/bin/rpdump ./opt/alpine/bin/rpload
[ -d $OPTPREFIX/bin ] && strip $OPTPREFIX/bin/*
[ -d $OPTPREFIX/sbin ] && strip $OPTPREFIX/sbin/*
[ -d $OPTPREFIX/usr/bin ] && strip $OPTPREFIX/usr/bin/*

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
