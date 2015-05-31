#!/bin/bash

SRCVER=nftables-0.3
PKG=$SRCVER-2 # with build version

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
pkg_install flex-2.5.35-1 || exit 2
pkg_install bison-2.4.2-1 || exit 2
pkg_install m4-1.4.14-1 || exit 2
pkg_install musl-libmnl-1.0.3-1 || exit 2
pkg_install musl-libnftnl-1.0.2-1 || exit 2
pkg_install musl-gmp-4.3.2-1 || exit 2
pkg_install musl-readline-6.1-2 || exit 2
pkg_install musl-ncurses-lib-5.7-3|| exit 2
pkg_install musl-kernel-headers-3.17.0-1 || exit 2

# Compile against musl:
pkg_install musl-1.1.8-1 || exit 2 
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat
sed -i 's/NFT_CT_LABEL\]/NFT_CT_LABELS\]/' src/ct.c
sed -i 's/NFT_CT_LABEL;/NFT_CT_LABELS;/' src/parser.y
patch -p0 < $PKGDIR/ct.pat || exit 1

#########
# Configure
LIBS=-lncursesw B-configure-3 --prefix=/usr --sysconfdir=/etc || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

sed -i 's/@$(MAKE) -s -f/@$(MAKE) -f/' Makefile.rules

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
(ldd ./usr/sbin/nft|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
# rm -rf opt/musl/share
# rm -rf opt/musl/man
[ -d usr/sbin ] && strip usr/sbin/*
mkdir -p etc/config.preconf
mv etc/nftables etc/config.preconf

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
