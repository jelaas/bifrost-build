#!/bin/bash

SRCVER=openssl-1.0.1m
PKG=musl-$SRCVER-2 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
CDIR=/var/tmp/src
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
pkg_install perl-5.10.1-1 || exit 2
pkg_install musl-1.1.5-1 || exit 2
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $CDIR; tar xf $SRC

#########
# Patch
cd $CDIR/$SRCVER
#libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat
patch -p0 < $PKGDIR/openssl.pat || exit 1
patch -p0 < $PKGDIR/default_ciphers.pat || exit 1

#########
# Configure
./Configure linux-elf --prefix=/opt/musl --bindir=/usr/bin --openssldir=/etc/ssl no-shared no-bf no-cast no-md2 no-mdc2 no-rc2 no-rc4 no-rc5 no-idea no-ripemd no-dso no-jpake no-md4 no-srp no-ssl2

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
sed 's/-O3/-Os -march=i586/g' Makefile > /tmp/config.$$
cp -f /tmp/config.$$ Makefile
rm -f /tmp/config.$$
sed -i 's/$${LDCMD} $${LDFLAGS} -o/$${LDCMD} $${LDFLAGS} -static -o/g' Makefile.shared

#sed -i 's/linux/xunil/' crypto/ui/ui_openssl.c 
#sed -i 's/TERMIO/TERMIOS/' Makefile

#########
# Compile
make depend
LDFLAGS="-static" make
rc=$?
echo Make result: $rc
[ "$rc" = 0 ] || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make INSTALL_PREFIX=$DST install

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/musl/bin/openssl|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf etc/ssl/man
rm -rf etc/ssl/misc
# rm -rf usr/share usr/man
#[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*

#########
# Make package
cd $DST || exit 1
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$CDIR/$SRCVER"
pkg_uninstall
exit 0
