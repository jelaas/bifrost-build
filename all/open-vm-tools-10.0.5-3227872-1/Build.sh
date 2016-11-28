#!/bin/bash

SRCVER=open-vm-tools-10.0.5-3227872
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
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
# pkg_install dependency1-1 || exit 2
# pkg_install groff-1.21-1 || exit 2 # Needed to convert man-pages: see below
pkg_install musl-kernel-headers-4.5.0-1 || exit 2
pkg_install musl-glib-2.24.2-1 || exit 2
pkg_install musl-pkg-config-0.23-1 || exit 2
pkg_install nfs-utils-1.1.6-1 || exit 2
pkg_install musl-libtirpc-1.0.1-1 || exit 2

pkg_install autoconf-2.65-1 || exit 2
pkg_install automake-1.10-1 || exit 2
pkg_install m4-1.4.14-1 || exit 2
pkg_install perl-5.10.1-1 || exit 2

# Compile against musl:
pkg_install musl-1.1.15-1 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat
patch -p2 < $PKGDIR/0001-lib-misc-Recognize-Bifrost.patch || exit 1
patch -p2 < $PKGDIR/0007-Fix-vmblock-linux-detection.patch || exit 1
patch -p2 < $PKGDIR/0002-open-vm-tools-Add-disable-werror-configure-option.patch || exit 1
patch -p2 < $PKGDIR/0008-Use-configure-test-for-sys-stat.h-include.patch || exit 1
patch -p2 < $PKGDIR/0003-Do-not-assume-that-linux-and-gnu-libc-are-the-same-t.patch || exit 1
patch -p2 < $PKGDIR/0009-Rename-poll.h-to-vm_poll.h.patch || exit 1
patch -p2 < $PKGDIR/0004-Use-configure-test-for-struct-timespec.patch || exit 1
patch -p2 < $PKGDIR/0010-Add-support-for-building-with-system-libtirpc.patch || exit 1
patch -p2 < $PKGDIR/0005-Fix-definition-of-ALLPERMS-and-ACCESSPERMS.patch || exit 1
patch -p2 < $PKGDIR/0011-gnu-ucontext.patch || exit 1
patch -p2 < $PKGDIR/0006-Use-configure-to-test-for-feature-instead-of-platfor.patch || exit 1

sed -i 's/"$MODULES vmhgfs"/"$MODULES"/' configure
sed -i 's/buildHgfsmounter=yes/buildHgfsmounter=no/' configure
sed -i 's,lib/hgfsUri/Makefile,,' configure
sed -i 's,vmhgfs-fuse/Makefile,,' configure
sed -i 's/SUBDIRS += plugins//' services/Makefile.am

#########
# Configure
export PATH=$PATH:/opt/musl/bin
$PKGDIR/B-configure-3 --prefix=/ \
 --with-kernel-release=4.5.0 \
 --disable-deploypkg \
 --disable-grabbitmqproxy \
 --disable-vgauth \
 --without-gtk2 \
 --without-procps \
 --without-icu \
 --without-x \
 --without-pam \
 --without-xmlsecurity \
 --without-xerces \
 --without-dnet \
 --without-gtkmm \
 --without-kernel-modules \
 --disable-werror \
 || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
sed -i 's/-Werror/-D_GNU_SOURCE/' configure

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Convert man-pages
cd $DST || exit 1
# for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf etc/pam.d lib include bin/vmware-hgfsclient sbin/mount.vmhgfs bin/vmware-xferlogs bin/vmware-checkvm share
[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*
[ -d sbin ] && strip sbin/*
[ -d usr/sbin ] && strip usr/sbin/*

#########
# Make package
cd $DST || exit 1
mkdir -p /lib/open-vm-tools/plugins/common /lib/open-vm-tools/plugins/vmsvc
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
