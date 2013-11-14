#!/bin/bash

SRCVER=xfsprogs-3.1.11
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
pkg_install musl-e2fsprogs-lib-1.42.5-1 || exit 2

# Compile against musl:
pkg_install musl-0.9.14-1 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

sed -i 's/mkfs quota/mkfs/' Makefile
sed -i 's/--best//' doc/Makefile

for f in $(find . -name \*.c) $(find . -name \*.h); do
	sed -i 's/__uint64_t/uint64_t/g' $f
	sed -i 's/__int64_t/int64_t/g' $f
	sed -i 's/__uint32_t/uint32_t/g' $f
	sed -i 's/__int32_t/int32_t/g' $f
	sed -i 's/__uint16_t/uint16_t/g' $f
	sed -i 's/__int16_t/int16_t/g' $f
	sed -i 's/__uint8_t/uint8_t/g' $f
	sed -i 's/__int8_t/int8_t/g' $f
done

sed -i 's,sys/ustat.h,sys/statfs.h,' libxfs/linux.c

sed -i 's/(uint)/(unsigned int)/' libdisk/fstype.h

patch -p0 < $PKGDIR/ustat.pat || exit 1
patch -p0 < $PKGDIR/missing.pat || exit 1

#########
# Configure
$PKGDIR/B-configure-3 --prefix=/ --enable-gettext=no --enable-lib64=no || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

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
# Convert man-pages
cd $DST || exit 1
# for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd sbin/mkfs.xfs|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf share
# rm -rf opt/musl/man
[ -d bin ] && strip bin/*
[ -d sbin ] && strip sbin/*

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
