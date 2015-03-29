#!/bin/bash

SRCVER=alpine-2.11
PKG=opt-$SRCVER-2 # with build version
# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.xz
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
pkg_install shadow-file-1 || exit 2
pkg_install xz-5.0.3-1 || exit 2
pkg_install musl-ncurses-lib-5.7-1 || exit 2
pkg_install musl-openssl-1.0.1m-3 || exit 2
pkg_install musl-1.1.5-1 || exit 2 
export CC=musl-gcc

# pkg_install groff-1.21-1 || exit 2 # Needed to convert man-pages: see below

# Compile against musl:
# pkg_install musl-0.9.1-1 || exit 2 
# export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC || exit 1

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

sed -i 's/$CPPFLAGS//g' configure
#sed -i 's/$LDFLAGS/-static -lssl -lcrypto/g' configure
sed -i 's/$LDFLAGS/-static/g' configure

#########
# Configure
OPTPREFIX=opt/alpine
LIBS="-lssl -lcrypto" B-configure-2 --prefix=/$OPTPREFIX --localstatedir=/var \
 --oldincludedir=/opt/musl/include --includedir=/opt/musl/include \
 --with-ssl-include-dir=/opt/musl/include --with-ssl-lib-dir=/opt/musl/lib \
 || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
for f in $(find . -name Makefile); do
	sed -i 's,/usr/lib,/opt/musl/lib,g' $f
	sed -i 's,/usr/include,/opt/musl/include,g' $f
	sed -i 's,CC=cc,CC=musl-gcc,' $f
	sed -i 's,CC=gcc,CC=musl-gcc,' $f
	sed -i 's/$(LINK)/musl-gcc -static -o $@/' $f
done

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative
OPTDIR=$DST/$OPTPREFIX
echo $PKG > $OPTDIR/pkgversion
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR

#########
# Convert man-pages
cd $DST || exit 1
# for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd ./opt/alpine/bin/alpine|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf opt/alpine/share ./opt/alpine/bin/rpdump ./opt/alpine/bin/rpload
[ -d $OPTPREFIX/bin ] && strip $OPTPREFIX/bin/*
[ -d $OPTPREFIX/sbin ] && strip $OPTPREFIX/sbin/*
[ -d $OPTPREFIX/usr/bin ] && strip $OPTPREFIX/usr/bin/*

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
