#!/bin/bash

SRCVER=bzip2-1.0.6
PKG=bzip2-bin-1.0.6-1 # with build version

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
# pkg_install dependency1-1 || exit 1

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
#B-configure-1 --prefix=/usr || exit 1
sedit  's/LDFLAGS=/LDFLAGS=-static/' Makefile
sedit  's/-O2/-march=i586 -Os/'  Makefile
sedit  's/\$(PREFIX)\/bin/\$(EPREFIX)\/bin/g'                     Makefile

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make "PREFIX=$DST/usr" "EPREFIX=$DST/usr" || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make "PREFIX=$DST/usr" "EPREFIX=$DST/usr" install || exit 1

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
(ldd usr/bin/bzip2|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf usr
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
