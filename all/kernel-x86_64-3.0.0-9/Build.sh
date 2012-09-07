#!/bin/bash

KVER=3.0.0
SRCVER=kernel-x86_64-$KVER
BUILDVER=9
PKG=$SRCVER-$BUILDVER # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz

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
rm -rf /home/build/mini-native-x86_64
pkg_install mini-native-x86_64-0.9.30.1-2 || exit 2
pkg_install passwd-file-1 || exit 2
pkg_install git-1.7.1-2 || exit 2

#########
# Install into dir under /var/tmp/install

echo "Updating build environment (git pull)"
cd /home/build/mini-native-x86_64/var/lib/build
/opt/git/bin/git pull

echo Setting up networking
cp /etc/resolv.conf /home/build/mini-native-x86_64/etc
cp /etc/hosts /home/build/mini-native-x86_64/etc

cp /var/spool/src/kernel-$KVER.tar.gz /home/build/mini-native-x86_64/var/spool/src || exit 1

echo Mounting proc and sysfs
setarch linux64 /bin/chroot /home/build/mini-native-x86_64 mount proc -t proc /proc
setarch linux64 /bin/chroot /home/build/mini-native-x86_64 mount sysfs -t sysfs /sys

echo Building kernel
setarch linux64 /bin/chroot /home/build/mini-native-x86_64 /var/lib/build/pkg_build kernel-x86_64-$KVER-$BUILDVER

echo Unmounting proc and sysfs
setarch linux64 /bin/chroot /home/build/mini-native-x86_64 umount /proc
setarch linux64 /bin/chroot /home/build/mini-native-x86_64 umount /sys

#########
# Copy packages
for p in kernel-x86_64-$KVER-$BUILDVER.tar.gz kernel-x86_64-firmware-$KVER-$BUILDVER.tar.gz kernel-x86_64-unsup-$KVER-$BUILDVER.tar.gz kernel-x86_64-vmlinux-$KVER-$BUILDVER.tar.gz kernel-x86_64-wireless-$KVER-$BUILDVER.tar.gz; do
	cp /home/build/mini-native-x86_64/var/spool/pkg/$p /var/spool/pkg || exit 1
done

#########
# Cleanup after a success
cd /var/lib/build
pkg_uninstall
exit 0
