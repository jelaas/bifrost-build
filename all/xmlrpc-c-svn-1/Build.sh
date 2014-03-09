#!/bin/bash

SRCVER=xmlrpc-c-svn
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
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
#./Fetch-source.sh || exit 1
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
pkg_available perl-5.10.1-1 autoconf-2.65-1 m4-1.4.14-1
pkg_install perl-5.10.1-1 || exit 2
pkg_install autoconf-2.65-1 || exit 2
pkg_install m4-1.4.14-1 || exit 2
#pkg_install libsigc++-2.3.1-1 || exit 2


#########
# Unpack sources into dir under /var/tmp/src
#cd $(dirname $BUILDDIR); tar xzf $SRC


#########
# Patch
#cd $BUILDDIR
cd /home/janhouse/src/xmlrpc-c-svn

libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat
export PTHREAD_LIBS=-lpthread
#./autogen.sh

#########
# Configure
B-configure-1 --prefix=/usr --disable-cplusplus || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf usr/share/man usr/share/info usr/share/doc
[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
#[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
