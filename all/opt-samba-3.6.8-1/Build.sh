#!/bin/bash

SRCVER=samba-3.6.8
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
#pkg_install openssl-0.9.8r-1 || exit 2
#pkg_install krb5-lib-1.8.1-1 || exit 2
#pkg_install openldap-2.4.26-1 || exit 2
pkg_install db-5.2.36-1  || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR/source3
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
OPTPREFIX=opt/samba
#LIBS="-lssl -lcrypto -lk5crypto -lkrb5support -lgssapi_krb5 -lgssrpc -lkdb5 -lkrb5_pkinit -lkrb5_encrypted_challenge -lcom_err" $PKGDIR/B-configure-1 --prefix=/$OPTPREFIX --localstatedir=/var || exit 1
#LIBS="-lssl -lcrypto /usr/lib/libk5crypto.a /usr/lib/libkrb5support.a /usr/lib/libgssapi_krb5.a /usr/lib/libgssrpc.a /usr/lib/libkdb5.a /usr/lib/libkrb5_pkinit.a /usr/lib/libkrb5_encrypted_challenge.a /usr/lib/libcom_err.a" $PKGDIR/B-configure-1 --prefix=/$OPTPREFIX --localstatedir=/var || exit 1
$PKGDIR/B-configure-1 --prefix=/$OPTPREFIX --sysconfdir=/$OPTPREFIX/etc --localstatedir=/var/samba --disable-pie --disable-relro --enable-shared-libs=no || exit 1
sleep 5
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
mkdir -p $OPTDIR/rc.d
echo yes > $OPTDIR/etc/config.flags/samba
echo $PKG > $OPTDIR/pkgversion
cp -p $PKGDIR/rc $OPTDIR/rc.d/rc.samba
chmod +x $OPTDIR/rc.d/rc.samba
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR
cp ../examples/smb.conf.default $OPTDIR/lib || exit 1
cp $PKGDIR/smb.conf.small.example $OPTDIR/lib

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd $OPTDIR/sbin/smbd|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf opt/samba/share opt/samba/swat opt/samba/lib/*.a
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
