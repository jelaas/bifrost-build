#!/bin/bash

SRCVER=squid-3.1.7
PKG=opt-squid-3.1.7-1 # with build version

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
pkg_available openssl-0.9.8p-1 perl-5.10.1-1
pkg_install openssl-0.9.8p-1 || exit 2
pkg_install perl-5.10.1-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat
sed -i "s:\$(localstatedir)/logs/squid\.pid:/var/run/squid\.pid:" src/Makefile.in

#########
# Configure
B-configure-1 --prefix=$DST/opt/squid --localstatedir=$DST/var/cache/squid --enable-auth="basic" \
 --enable-digest-auth-helpers="" --enable-ntlm-auth-helpers="" --disable-loadable-modules\
 --disable-dependency-tracking --without-dl --with-large-files || exit 1
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
make install

mkdir  -p  $DST/var/log/squid

OPTDIR=$DST/opt/squid
mkdir -p $OPTDIR/etc/config.flags
mkdir -p $OPTDIR/etc/config.data
echo root > $OPTDIR/etc/config.data/suuser
echo /var/log/squid > $OPTDIR/etc/config.data/logdir
echo /var/cache/squid > $OPTDIR/etc/config.data/cachedir
mkdir -p $OPTDIR/rc.d
echo yes > $OPTDIR/etc/config.flags/squid
cp -p $PKGDIR/rc $OPTDIR/rc.d/rc.squid
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR

#########
# Check result
cd $DST
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/squid/sbin/squid|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf opt/squid/share/man
rm -f opt/squid/etc/mime.conf opt/squid/etc/msntauth.conf opt/squid/etc/cachemgr.conf
rm -f opt/squid/etc/squid.conf
strip opt/squid/libexec/* opt/squid/bin/* opt/squid/sbin/*

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
