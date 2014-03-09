#!/bin/bash

SRCVER=patch-2.7.1
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
<<<<<<< HEAD
=======
[ -f /var/spool/src/$SRCVER.tar.bz2 ] && SRC=/var/spool/src/$SRCVER.tar.bz2
>>>>>>> 6db6c7547d7bab1da51e53b5193fa8e9d9509b18
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
<<<<<<< HEAD
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 1

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar zxf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#patch -p1 < $PKGDIR/threads.patch

#########
# Configure
B-configure-1 --prefix=/usr || exit 1

#########
# Post configure patch
#patch -p0 < $PKGDIR/spawn_h.pat

#########
# Compile
make -j 3 || exit 1
=======
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

# Compile against musl:
pkg_install musl-0.9.10-1 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
B-configure-3 --prefix=/usr || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make V=1 || exit 1
>>>>>>> 6db6c7547d7bab1da51e53b5193fa8e9d9509b18

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
<<<<<<< HEAD
# Check result
cd $DST
=======
# Convert man-pages
cd $DST || exit 1
# for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
>>>>>>> 6db6c7547d7bab1da51e53b5193fa8e9d9509b18
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
<<<<<<< HEAD
cd $DST
# rm -rf usr/share usr/man
[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*

#########
# Make package
cd $DST
=======
cd $DST || exit 1
# rm -rf usr/share usr/man
[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*
[ -d sbin ] && strip sbin/*
[ -d usr/sbin ] && strip usr/sbin/*

#########
# Make package
cd $DST || exit 1
>>>>>>> 6db6c7547d7bab1da51e53b5193fa8e9d9509b18
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
