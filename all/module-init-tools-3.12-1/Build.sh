#!/bin/bash

SRCVER=module-init-tools-3.12
PKG=$SRCVER-1 # with build version

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
pkg_install zlib-1.2.5-1 || exit 2
pkg_install flex-2.5.35-1 || exit 2
pkg_install gnupg-1.4.10-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat
make clean

#########
# Configure
LIBS="-static" B-configure-1 --prefix=/ --enable-zlib || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
sed -i 's/-Wl,-Bstatic -lz -Wl,-Bdynamic/-lz/' build/Makefile

#########
# Compile
make MANS= || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST MANS=

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd ./bin/lsmod|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
# rm -rf usr/share usr/man
strip sbin/* bin/*
rm -f ./sbin/insmod.static

#########
# Make package
cd $DST || exit 1
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
