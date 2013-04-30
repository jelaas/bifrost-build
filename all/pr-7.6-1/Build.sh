#!/bin/bash

VER=7.6
SRCVER=coreutils-$VER
PKG=pr-$VER-1 # with build version

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
pkg_install musl-0.9.10-1 || exit 2
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
(cd lib; make) || exit 1
(cd src; make version.h; make pr V=1) || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p $DST/usr/bin || exit 1
cp -p src/pr $DST/usr/bin || exit 1

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd usr/bin/pr|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
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
