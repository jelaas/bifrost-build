#!/bin/bash

SRCVER=gdb-6.3
PKG=opt-$SRCVER-1 # with build version

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
pkg_install ncurses-lib-5.7-1 || exit 2
pkg_install fake-libintl-2 || exit 2
pkg_install flex-2.5.35-1 || exit 2
pkg_install readline-6.1-1 || exit 2
pkg_install m4-1.4.14-1 || exit 2
pkg_install bison-2.4.2-1 || exit 2


#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1

#########
# Configure
#B-configure-1
./configure --prefix=/opt/gdb --with-mpfr --with-gmp || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
#patch -p0 < $PKGDIR/gdb_Makefile_intl.pat
#sed -i "s/rdynamic/static/" gdb/config/i386/linux64.mh
#sed -i "s/rdynamic/static/" gdb/config/i386/linux.mh

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
cd $BUILDDIR || exit 1
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
#(ldd opt/gdb/bin/gdb|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf opt/gdb/info opt/gdb/share opt/gdb/lib opt/gdb/include opt/gdb/man
strip opt/gdb/bin/*

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
