#!/bin/bash

SRCVER=l2tpns-2.1.21
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
pkg_install groff-1.21-1 || exit 2 # Needed to convert man-pages: see below
pkg_install passwd-file-1 || exit 2
pkg_install group-file-1 || exit 2

# Compile against musl:
pkg_install musl-1.1.3-1 || exit 2 
export CC=musl-gcc

pkg_install musl-kernel-headers-3.6.0-1 || exit 2
pkg_install musl-libcli-1.9.7-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC
rm -rf $BUILDDIR.orig
cp -rp $BUILDDIR $BUILDDIR.orig

#########
# Patch
cd $BUILDDIR || exit 1
libtool_fix-1
patch -p1 < $PKGDIR/bifrost.pat || exit 1

#########
# Configure
OPTPREFIX=opt/l2tpns
#B-configure-3 --prefix=/$OPTPREFIX --localstatedir=/var || exit 1
#[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST || exit 1
OPTDIR=$DST/$OPTPREFIX
mkdir -p $OPTDIR/etc/config.flags
mkdir -p $OPTDIR/etc/config.preconf
mkdir -p $OPTDIR/rc.d
echo yes > $OPTDIR/etc/config.flags/l2tpns
echo $PKG > $OPTDIR/pkgversion
cp -p $PKGDIR/rc $OPTDIR/rc.d/rc.l2tpns
chmod +x $OPTDIR/rc.d/rc.l2tpns
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR
mv $OPTDIR/etc/l2tpns/startup-config $OPTDIR/etc/l2tpns/startup-config.sample
mv $OPTDIR/etc/l2tpns/ip_pool $OPTDIR/etc/l2tpns/ip_pool.sample
mv $OPTDIR/etc/l2tpns/users $OPTDIR/etc/l2tpns/users.sample

#########
# Convert man-pages
cd $DST || exit 1
for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd $OPTPREFIX/sbin/l2tpns|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
# rm -rf usr/share usr/man
rm -rf $OPTPREFIX/lib
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
