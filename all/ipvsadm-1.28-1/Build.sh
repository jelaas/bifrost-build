#!/bin/bash

SRCVER=ipvsadm-1.28
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
pkg_install musl-libnl-3.2.25-1 || exit 2
pkg_install musl-popt-1.16-1 || exit 2
pkg_install musl-pkg-config-0.23-1 || exit 2

# Compile against musl:
pkg_install musl-1.1.15-1 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR) || exit 1; tar xf $SRC || exit 1

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
patch -p0 < $PKGDIR/rc.pat
sed -i 's/gcc/musl-gcc/' Makefile
sed -i 's/gcc/musl-gcc/' libipvs/Makefile
sed -i 's, -g, -I/opt/musl/include/libnl3,' Makefile
sed -i 's, -g, -I/opt/musl/include/libnl3,' libipvs/Makefile
sed -i 's/-fPIC//' libipvs/Makefile
sed -i 's/$(STATIC_LIB) $(SHARED_LIB)/$(STATIC_LIB)/' libipvs/Makefile
sed -i 's,/etc/rc.d/init.d,/etc/rc.d,' Makefile
sed -i 's,$(INIT)/ipvsadm,$(INIT)/rc.ipvsadm,' Makefile

#########
# Configure
#B-configure-3 --prefix=/usr || exit 1
#[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
BUILD_ROOT=$DST make install # --with-install-prefix may be an alternative

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
rm -rf usr/man
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
