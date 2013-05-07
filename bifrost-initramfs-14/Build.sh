#!/bin/bash

SRCVER=bifrost-initramfs
PKG=$SRCVER-14 # with build version

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
./Fetch-source.sh || exit $?
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

pkg_install util-linux-ng-lib-2.17.2-1 || exit 2
pkg_install cpio-2.11-1 || exit 2
pkg_install e2fsprogs-1.42.5-2 || exit 2

mkdir -p $BUILDDIR
cp $PKGDIR/init.c $BUILDDIR

#########
# Compile
cd $BUILDDIR
gcc -Wall -static -o init init.c -lblkid -luuid || exit 1
strip init

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"               
mkdir -p $DST/pkg/boot $DST/cpio/etc $DST/cpio/dev $DST/cpio/sys $DST/cpio/proc $DST/cpio/rootfs
mknod $DST/cpio/dev/console c 5 1
cp init $DST/cpio || exit 1
cp /sbin/e2fsck $DST/cpio || exit 1
cp /sbin/resize2fs $DST/cpio || exit 1
ln -s /proc/mounts $DST/cpio/etc/mtab
cd $DST/cpio || exit 1
find . | cpio --quiet -H newc -o > $DST/pkg/boot/initramfs.cpio

#########
# Make package
cd $DST/pkg || exit 1
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
