#!/bin/bash

SRCVER=coreutils-7.6
PKG=$SRCVER-5 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Simple inplace edit with sed.
# Usage: sedit 's/find/replace/g' Filename
function sedit {
    sed $1 $2 > /tmp/sedit.$$
    cp /tmp/sedit.$$ $2
    rm /tmp/sedit.$$
}

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
pkg_install musl-0.9.9-2 || exit 2
pkg_install musl-devtag-1.0.7-1 || exit 2
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
echo "#define _XOPEN_SOURCE 600" > /tmp/dd.$$
echo "#include <fcntl.h>" >> /tmp/dd.$$
cat src/dd.c >> /tmp/dd.$$
cp /tmp/dd.$$ src/dd.c; rm -f /tmp/dd.$$
patch -p0 < $PKGDIR/stty_devtag.pat || exit 1

for f in c-strtod.c freadahead.c  freading.c    freadptr.c fseterr.c freadseek.c; do
	cp -f $PKGDIR/$f lib
done

sed -i "s/elf_sys=yes/elf_sys=no/" configure

#########
# Configure
LIBS="-ldevtag" $PKGDIR/B-configure-1 --prefix=/usr --bindir=/bin --disable-acl --disable-assert || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make V=1 || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
(ldd bin/ls|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf usr/share usr
[ -d bin ] && strip bin/*

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
