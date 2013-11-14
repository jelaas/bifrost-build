#!/bin/bash

SRCVER=e2fsprogs-1.42.5
PKG=musl-e2fsprogs-lib-1.42.5-1 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 1
pkg_install musl-0.9.14-1 || exit 2 
pkg_install musl-kernel-headers-3.6.0-1 || exit 2
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
sed -i 's/__uint64_t/uint64_t/' lib/ext2fs/unix_io.c || exit 1

#########
# Configure
B-configure-3 --prefix=/opt/musl --bindir=/bin --sbindir=/sbin\
 --disable-defrag --disable-debugfs --disable-imager --disable-resizer --disable-uuidd || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make V=1 || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
#make install DESTDIR=$DST
make install-libs DESTDIR=$DST

#########
# Check result
cd $DST
#(ldd sbin/mke2fs|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
# rm -rf usr/share usr/man
rm -rf opt/musl/share bin sbin usr/bin

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
