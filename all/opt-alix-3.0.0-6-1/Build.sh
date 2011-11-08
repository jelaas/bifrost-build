#!/bin/bash

KERNEL=3.0.0-6
SRCVER=alix-$KERNEL
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
pkg_available kernel-x86_32-$KERNEL || exit 2
pkg_install egetty-0.2-1 || exit 2
pkg_install kernel-x86_32-unsup-$KERNEL || exit 1
pkg_install kernel-x86_32-wireless-$KERNEL || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p $DST/bin $DST/sbin $DST/etc $DST/boot/grub $DST/etc/eth-detect.d
cd $DST

cp -p /bin/econsole $DST/bin
cp -p /sbin/egetty $DST/sbin
cp -p $PKGDIR/inittab $DST/etc
cp -p $PKGDIR/menu.lst $DST/boot/grub 
cp -p $PKGDIR/51_alix.conf $DST/etc/eth-detect.d
DIR=lib/modules/$KERNEL-bifrost-x86_32/kernel/drivers/net
mkdir -p $DST/$DIR $DST/$DIR/wireless/ath/ath5k
for f in via-rhine.ko mii.ko wireless/ath/ath.ko wireless/ath/ath5k/ath5k.ko; do
	cp -p /$DIR/$f $DST/$DIR/$f
done

DIR=lib/modules/$KERNEL-bifrost-x86_32/kernel/net
mkdir -p $DST/$DIR
for f in wireless mac80211; do
	cp -rp /$DIR/$f $DST/$DIR
done

#########
# Clean up
cd $DST || exit 1

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
