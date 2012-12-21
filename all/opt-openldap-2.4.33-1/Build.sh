#!/bin/bash

SRCVER=openldap-2.4.33
PKG=opt-$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tgz
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
pkg_install groff-1.21-1 || exit 2 # Needed to convert man-pages: see below
pkg_install db-5.2.36-1 || exit 2
pkg_install openssl-0.9.8x-1 || exit 2
pkg_install tcp_wrappers-7.6-1 || exit 2

# Compile against musl:
# pkg_install musl-0.9.1-1 || exit 2 
# export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure

OPTPREFIX=opt/openldap
B-configure-1 --prefix=/$OPTPREFIX --localstatedir=/var \
	--with-tls=openssl \
	--enable-syslog \
	--enable-slapd \
	--enable-wrappers \
	--enable-bdb=yes --enable-hdb=yes \
	--enable-passwd=yes \
	--enable-local \
	--without-fetch \
    --enable-ldap --enable-overlays --enable-relay \
 || exit 1
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
OPTDIR=$DST/$OPTPREFIX
mkdir -p $OPTDIR/etc/config.flags
mkdir -p $OPTDIR/etc/config.preconf
mkdir -p $OPTDIR/rc.d
echo yes > $OPTDIR/etc/config.flags/slapd
echo $PKG > $OPTDIR/pkgversion
cp -p $PKGDIR/rc $OPTDIR/rc.d/rc.slapd
chmod +x $OPTDIR/rc.d/rc.slapd
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR

#########
# Convert man-pages
cd $DST || exit 1
for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
[ -f opt/openldap/libexec/slapd ] || exit 1
(ldd opt/openldap/libexec/slapd|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf opt/openldap/lib var opt/openldap/include opt/openldap/share/man/man3
mv opt/openldap/etc/openldap/slapd.conf opt/openldap/etc/config.preconf || exit 1
mv opt/openldap/etc/openldap/slapd.ldif opt/openldap/etc/config.preconf || exit 1
mv opt/openldap/etc/openldap/ldap.conf opt/openldap/etc/config.preconf || exit 1
rm -f opt/openldap/etc/openldap/*.default

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
