#!/bin/bash

SRCVER=minicom-2.4
PKG=opt-minicom-2.4-5 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 1
pkg_install libiconv-1.13.1-1 || exit 2
pkg_install ncurses-lib-5.7-1 || exit 2
pkg_install devtag-1.0.6-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
patch -p1 < $PKGDIR/minicom_devtag.pat || exit 1
patch -p0 < $PKGDIR/rtscts.pat || exit 1

#########
# Configure
$PKGDIR/B-configure-1 --disable-nls --enable-dfl-baud=38400\
 --without-libintl-prefix --prefix=/opt/minicom --enable-lock-dir=/tmp || exit 1

sed -i 's,/dev/tty8,/dev/ttyUSB0,' config.h

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
mkdir -p $DST/opt/minicom/etc
touch $DST/opt/minicom/etc/minirc.dfl

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/minicom/bin/minicom|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf opt/minicom/share
strip opt/minicom/bin/*

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
