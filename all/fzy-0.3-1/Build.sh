#!/bin/bash

SRCVER=fzy-0.3
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Fetch sources
./Fetch-source.sh || exit $?
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 2
# pkg_install groff-1.21-1 || exit 2 # Needed to convert man-pages: see below
pkg_install  file-5.04-1 || exit 2

# Compile against musl:
pkg_install musl-1.1.3-1 || exit 2
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
sed -i 's/CFLAGS+=/CFLAGS+=-Os -march=i586 -static /' Makefile
#libtool_fix-1
#patch -p0 < $PKGDIR/teamnl.pat || exit 1

#########
# Configure

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm    -rf "$DST"
mkdir -p "${DST}/bin"
chmod +x fzy
cp fzy "${DST}/bin/fzy"

#########
# Check result
cd $DST
[ -f bin/fzy ] || exit 1
(file bin/fzy | grep -qs "statically linked") || exit 1

#########
# Clean up
cd $DST || exit 1
[ -d bin ] && strip bin/fzy

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
