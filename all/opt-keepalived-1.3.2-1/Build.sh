#!/bin/bash

SRCVER=keepalived-1.3.2
PKG=opt-$SRCVER-1 # with build version

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
./Fetch-source.sh || exit 1
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
pkg_install musl-1.1.16-1 || exit 2 
export CC=musl-gcc
pkg_install musl-kernel-headers-3.17.0-1 || exit 2
pkg_install musl-openssl-1.0.1u-1 || exit 2
pkg_install musl-popt-1.16-1 || exit 2
pkg_install musl-libnl-3.2.25-1 || exit 2
pkg_install groff-1.21-1 || exit 2
pkg_install musl-pkg-config-0.23-1 || exit 2
pkg_install musl-net-snmp-5.7.3-1 || exit 2
pkg_install musl-tcp_wrappers-7.6-1 || exit 2
pkg_install musl-libnfnetlink-1.0.1-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
#patch -p0 < $PKGDIR/utils_h.pat || exit 1
sed -i 's/__uint64_t/uint64_t/' keepalived/vrrp/vrrp_if.c
sed -i 's/__uint32_t/uint32_t/' keepalived/vrrp/vrrp_if.c
sed -i 's/__uint16_t/uint16_t/' keepalived/vrrp/vrrp_if.c
sed -i 's/__uint8_t/uint8_t/' keepalived/vrrp/vrrp_if.c

sed -i 's/$NETSNMP_LIBS_EXT/$NETSNMP_LIBS_EXT -lwrap/' configure

#########
# Configure
OPTPREFIX=opt/keepalived
NETSNMP_CONFIG=/opt/musl/bin/net-snmp-config LIBS="-lm -lnl-3 -lwrap" \
 $PKGDIR/B-configure-3 --prefix=/opt/keepalived --enable-snmp --enable-sha1 || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make V=1 || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST

mv $DST/opt/keepalived/etc/keepalived/keepalived.conf $DST/opt/keepalived/etc/keepalived/keepalived.conf.sample

OPTDIR=$DST/$OPTPREFIX
mkdir -p $OPTDIR/etc/config.flags
mkdir -p $OPTDIR/etc/config.preconf
mkdir -p $OPTDIR/rc.d
echo yes > $OPTDIR/etc/config.flags/keepalived
echo $PKG > $OPTDIR/pkgversion
cp -p $PKGDIR/rc $OPTDIR/rc.d/rc.keepalived
chmod +x $OPTDIR/rc.d/rc.keepalived
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR

#########
# Convert man-pages
cd $DST || exit 1
for f in $(find . -path \*man/man\*); do if [ -f $f ]; then groff -T utf8 -man $f > $f.txt; rm $f; fi; done

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd opt/keepalived/sbin/keepalived|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
# rm -rf usr/share usr/man
strip opt/keepalived/sbin/* opt/keepalived/bin/*

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
