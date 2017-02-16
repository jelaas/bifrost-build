#!/bin/bash

SRCVER=ncurses-5.7
PKG=musl-ncurses-lib-5.7-1 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 1
pkg_install musl-0.9.9-1 || exit 2
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

#########
# Configure
#B-configure-2 --prefix=/opt/musl --datadir=/usr/share || exit 1
B-configure-2 --prefix=/opt/musl --datadir=/usr/share \
    --with-default-terminfo-dir=/usr/share/terminfo   \
    --with-terminfo-dirs="/etc/terminfo:/lib/terminfo:/usr/share/terminfo" || exit 1

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
mkdir -p usr/bin
mv opt/musl/bin/ncurses5-config usr/bin
rm -rf opt/musl/man opt/musl/bin opt/musl/share
chmod +x usr/bin/ncurses5-config

#mv opt/musl/include/ncurses /opt/musl
#rmdir opt/musl/include
#mv /opt/musl/ncurses opt/musl/include

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
