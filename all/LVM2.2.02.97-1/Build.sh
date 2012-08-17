#!/bin/bash

SRCVER=LVM2.2.02.97
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tgz
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
pkg_install pkg-config-0.23-1 || exit 2

# Compile against musl:
# pkg_install musl-0.9.1-1 || exit 2 
# export CC=musl-gcc

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
export PATH=$PATH:$BUILDDIR
B-configure-2 --prefix=/usr --enable-static_link --with-optimisation=-Os || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
(cd include && make) || exit 1
(cd libdm && make && cp ioctl/libdevmapper.a .) || exit 1
make device-mapper || exit 1
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
#make install_device-mapper DESTDIR=$DST # --with-install-prefix may be an alternative
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Convert man-pages
cd $DST || exit 1
# for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd usr/sbin/lvm|grep -qs "not a dynamic executable") || exit 1
(ldd usr/sbin/dmsetup|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf usr/share usr/lib/libdevmapper.so* usr/sbin/lvm.static usr/sbin/dmsetup.static
mv etc/lvm/lvm.conf etc/lvm/lvm.conf.sample
[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*
[ -d sbin ] && strip sbin/*
[ -d usr/sbin ] && strip usr/sbin/*

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
