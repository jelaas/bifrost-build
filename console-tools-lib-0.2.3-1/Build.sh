#!/bin/bash

SRCVER=console-tools-0.2.3
PKG=console-tools-lib-0.2.3-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 1
pkg_available perl-5.10.1-1 console-data-1999.08.29-1 flex-2.5.35-1 || exit 1
pkg_install flex-2.5.35-1 || exit 1
pkg_install perl-5.10.1-1 || exit 1
pkg_install console-data-1999.08.29-1 || exit 1

#########
# Unpack sources into dir under /var/tmp/src
./Fetch-source.sh || exit 1
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
#libtool_fix-1
patch -p0 < $PKGDIR/fontstruct_c.pat || exit 1
patch -p0 < $PKGDIR/acm_c.pat || exit 1
patch -p0 < $PKGDIR/local_h.pat || exit 1
patch -p0 < $PKGDIR/showkey_c.pat || exit 1
patch -p0 < $PKGDIR/codepage_c.pat || exit 1

#########
# Configure
$PKGDIR/B-configure-1 --disable-nls --prefix=/usr || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
echo '#undef HAVE_LOCALE_H' >> config.h
sed 's/ doc / /' Makefile > /tmp/m.$$
cp /tmp/m.$$ Makefile; rm -f /tmp/m.$$

#########
# Compile
make -j 3 || exit 1

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
rm -rf usr/share usr/bin usr/man

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
