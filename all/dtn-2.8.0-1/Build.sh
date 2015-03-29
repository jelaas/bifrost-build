#!/bin/bash
#
# Contributed by:
# Mozhdeh Kamel <mozhdeh@kth.se>
#

SRCVER=dtn-2.8.0
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tgz
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
#vailable autoconf-2.65-1 tcl-8.5.10-1                        
pkg_install autoconf-2.65-1 || exit 2                             
pkg_install tcl8.5.10-1 || exit 2                                
pkg_install perl-5.10.1-2 || exit 2                              
pkg_install db-4.7.25-1 || exit 2                                 
pkg_install m4-1.4.14-1 || exit 2                                 
pkg_install tcllib-1.13-1 || exit 2                               
pkg_install tclreadline-2.1.0-1 || exit 2                         
pkg_install fake-execinfo_h-1 || exit 2                           
pkg_install STLport-5.2.1-1 || exit 2                             
pkg_install gcc-4.6.1-2 || exit 2     
pkg_install oasys-1.5.0-1 || exit 2


#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
./build-configure.sh
B-configure-1 --prefix=/usr CC=gcc CXX=g++ --disable-ecl --disable-edp|| exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

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
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
# rm -rf usr/share usr/man
[ -d bin ] && strip bin/*
[ -d usr/bin ] && strip usr/bin/*

#########
# Make package
cd $DST || exit 1

mkdir lib
cp /usr/lib/libdl.so.0 lib
cp /usr/lib/libpthread.so.0 lib
cp /usr/lib/libstdc++.so.6  usr/lib
cp /usr/lib/libm.so.0 lib
cp /usr/lib/libgcc_s.so.1 usr/lib
cp /usr/lib/libc.so.0  lib
cp /usr/lib/ld-uClibc.so.0 lib

tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
