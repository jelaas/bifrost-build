#!/bin/bash

BUILDVER=7
PKG=meta-bifrost-bin64-$BUILDVER # with build version
DST="/var/tmp/install/$PKG"

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

pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
umount /home/build/mini-native-x86_64/proc
umount /home/build/mini-native-x86_64/sys
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

echo Mounting proc and sysfs
setarch linux64 /bin/chroot /home/build/mini-native-x86_64 mount proc -t proc /proc
setarch linux64 /bin/chroot /home/build/mini-native-x86_64 mount sysfs -t sysfs /sys

echo Building 
for F in ethtool-v3.16-1 strace-4.5.20-2 tcpdump-4.1.1-1 binutils-x86_64-2.20.1-1; do
    echo BUILD: Building $F
    setarch linux64 /bin/chroot /home/build/mini-native-x86_64 /var/lib/build/pkg_build $F || exit 1
done

echo BUILD: packages built

#########
# Copy packages
function untar {
    if [ ! -f /home/build/mini-native-x86_64/var/spool/pkg/$1.tar.gz ]; then
	echo "BUILD ERROR: $1 not built. Trying to build it."
	setarch linux64 /bin/chroot /home/build/mini-native-x86_64 /var/lib/build/pkg_build $1 || exit 1
	exit 2
    fi
    echo "BUILD UNTAR: $1"
    tar xvf /home/build/mini-native-x86_64/var/spool/pkg/$1.tar.gz $2 || exit 1
}

rm -rf "$DST"
mkdir -p $DST
cd $DST || exit 1

untar ethtool-v3.16-1 || exit 1
untar strace-4.5.20-2 || exit 1
untar tcpdump-4.1.1-1 || exit 1
untar binutils-x86_64-2.20.1-1 || exit 1

echo BUILD: Unmounting proc and sysfs
setarch linux64 /bin/chroot /home/build/mini-native-x86_64 umount /proc
setarch linux64 /bin/chroot /home/build/mini-native-x86_64 umount /sys

cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz .

rm -rf $DST
#########
# Cleanup after a success
cd /var/lib/build
pkg_uninstall
exit 0
