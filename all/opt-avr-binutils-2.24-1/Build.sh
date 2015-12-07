#!/bin/bash

SRCVER=binutils-2.24
PKG=opt-avr-$SRCVER-1 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.bz2
CDIR=/var/tmp/src
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
# pkg_install dependency-1.1 || exit 1

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $CDIR; tar xf $SRC

#########
# Patch
cd $CDIR/$SRCVER
libtool_fix-1
#patch -p0 < $PKGDIR/bfd-makefile_in.pat || exit 1
sed -i 's/doc po//' bfd/Makefile.in
#patch -p0 < $PKGDIR/30-binutils-2.20.1-avr-size.patch || exit 1

#########
# Configure
mkdir  buildit
cd     buildit || exit 1
PREFIX=opt/dev-avr
$PKGDIR/B-configure --target=avr --disable-nsl --enable-install-libbfd --disable-werror --prefix=/$PREFIX || exit 1

#########
# Post configure patch

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
rm -rf $PREFIX/share $PREFIX/avr/bin
strip $PREFIX/bin/*

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz --hard-dereference .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$CDIR/$SRCVER"
pkg_uninstall
exit 0
