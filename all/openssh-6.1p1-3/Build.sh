#!/bin/bash

SRCVER=openssh-6.1p1
PKG=$SRCVER-3 # with build version

PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
CDIR=/var/tmp/src
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
# pkg_install dependency-1.1 || exit 1
pkg_install zlib-1.2.7-1 || exit 2
pkg_install tcp_wrappers-7.6-1 || exit 2
pkg_install openssl-0.9.8zb-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $CDIR; tar xf $SRC

#########
# Patch
cd $CDIR/$SRCVER
libtool_fix-1
patch -p1 < $PKGDIR/openssh6.1-dynwindow_noneswitch.diff || exit 1
patch -p0 < $PKGDIR/openssh-6.1p1-bifrost.pat || exit 1

#########
# Configure
$PKGDIR/B-configure-1 --prefix=/usr --with-tcp-wrappers --without-pam  --with-md5-passwords --sysconfdir=/etc/ssh --without-bsd-auth --without-kerberos5 --without-pam --without-osfsia \
 --without-skey --without-stackprotect --without-selinux || exit 1

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
# rm -rf usr/share usr/man
rm -rf usr/share var etc
[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*
[ -d usr/sbin ] && strip usr/sbin/*
strip usr/libexec/*

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$CDIR/$SRCVER"
pkg_uninstall
exit 0
