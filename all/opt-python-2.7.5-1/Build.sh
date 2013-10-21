#!/bin/bash

VER=2.7.5
SRCVER=Python-$VER
PKG=opt-python-$VER-1 # with build version

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
# pkg_available dependency1-1 dependency2-1
pkg_install musl-0.9.14-1 || exit 2 
export CC=musl-gcc
pkg_install musl-pkg-config-0.23-1 || exit 2
pkg_install musl-bzip2-lib-1.0.6-2 || exit 2
pkg_install musl-zlib-1.2.7-1 || exit 2
pkg_install musl-ncurses-lib-5.7-3 || exit 2
pkg_install musl-readline-6.1-2 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat
sed -i 's/$WRAP -O3//' configure
sed -i 's,/usr/lib64,/opt/musl/lib,' setup.py
sed -i 's,/usr/include,/opt/musl/include,' setup.py

#########
# Configure
cp $PKGDIR/Setup Modules/Setup || exit 1
$PKGDIR/B-configure --prefix=/opt/python || exit 1
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

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/python/bin/python|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf opt/python/lib/libpython2.7.a opt/python/share opt/python/lib/python2.7/lib2to3/tests opt/python/lib/python2.7/test opt/python/lib/python2.7/lib-tk/test opt/python/lib/python2.7/bsddb/test opt/python/lib/python2.7/ctypes/test opt/python/lib/python2.7/json/tests opt/python/lib/python2.7/email/test opt/python/lib/python2.7/unittest/test opt/python/lib/python2.7/distutils/tests opt/python/lib/python2.7/sqlite3/test
strip opt/python/bin/*

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
