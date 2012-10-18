#!/bin/bash

SRCVER=php-5.3.17
PKG=opt-php-5.3.17-2 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.bz2
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
./Fetch-source.sh || exit 1
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
pkg_install groff-1.21-1 || exit 2

pkg_install openssl-0.9.8x-1 || exit 2
pkg_install flex-2.5.35-1 || exit 2
pkg_install bison-2.4.2-1 || exit 2
pkg_install m4-1.4.14-1 || exit 2
pkg_install readline-6.1-1 || exit 2
pkg_install zlib-1.2.6-1 || exit 2
pkg_install sed-4.2.1-1 || exit 2
pkg_install curl-devel-7.20.1-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
patch -p0 < $PKGDIR/php_crypt_r.pat
patch -p0 < $PKGDIR/force_redirect.pat || exit 1

#########
# Configure
B-configure-1 --prefix=/opt/php-5.3 \
 --disable-xml --disable-libxml --without-xmlrpc --disable-dom --disable-xmlreader\
 --disable-xmlwriter --disable-simplexml --without-iconv --enable-pcntl\
 --without-pear --with-curl|| exit 1

[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat
sed -i 's/-export-dynamic/-static/' Makefile

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
INSTALL_ROOT=$DST make install # --with-install-prefix may be an alternative
echo $PKG > $DST/opt/php-5.3/pkgversion
cp php.ini-production $DST/opt/php-5.3/bin

#########
# Convert man-pages
cd $DST || exit 1
for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/php-5.3/bin/php|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf opt/php-5.3/include opt/php-5.3/lib
strip opt/php-5.3/bin/*

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
