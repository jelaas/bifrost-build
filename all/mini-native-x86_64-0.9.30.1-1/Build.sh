#!/bin/bash

SRCVER=mini-native-x86_64-0.9.30.1
PKG=$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.bz2
BUILDDIR=/var/tmp/src/mini-native-x86_64
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
pkg_install passwd-file-1 || exit 2
pkg_install git-1.7.1-2 || exit 2
pkg_install openssh-5.5p1-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR || exit 1
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
mkdir -p var/lib
cd var/lib || exit 1
/opt/git/bin/git clone git://github.com/jelaas/bifrost-build-x86_64.git build || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p $DST/home/build
mv $BUILDDIR $DST/home/build/mini-native-x86_64
cp -p $DST/home/build/mini-native-x86_64/var/lib/build/util/chroot-x86_64.sh $DST/home/build
cp -p $DST/home/build/mini-native-x86_64/var/lib/build/util/chroot-setup.sh $DST/home/build/mini-native-x86_64/bin

cp /etc/resolv.conf $DST/home/build/mini-native-x86_64/etc
cp /etc/hosts $DST/home/build/mini-native-x86_64/etc

setarch linux64 /bin/chroot $DST/home/build/mini-native-x86_64 mount proc -t proc /proc
setarch linux64 /bin/chroot $DST/home/build/mini-native-x86_64 mount sysfs -t sysfs /sys
setarch linux64 /bin/chroot $DST/home/build/mini-native-x86_64 mdev -s
setarch linux64 /bin/chroot $DST/home/build/mini-native-x86_64 ln -s /proc/self/fd /dev/fd
setarch linux64 /bin/chroot $DST/home/build/mini-native-x86_64 ln -s /dev/fd/0 /dev/stdin
setarch linux64 /bin/chroot $DST/home/build/mini-native-x86_64 ln -s /dev/fd/1 /dev/stdout
setarch linux64 /bin/chroot $DST/home/build/mini-native-x86_64 ln -s /dev/fd/2 /dev/stderr

echo Building tar
setarch linux64 /bin/chroot $DST/home/build/mini-native-x86_64 /var/lib/build/pkg_build tar-1.23-1
echo Installing tar
setarch linux64 /bin/chroot $DST/home/build/mini-native-x86_64 /var/lib/build/pkg_install --permanent tar-1.23-1

for pkg in passwd-file-1 ncurses-lib-5.7-1 git-1.7.1-2 openssh-5.5p1-1 perl-5.10.1-1\
	e2fsprogs-1.41.11-1 module-init-tools-3.12-1 cpio-2.11-1 util-linux-ng-lib-2.17.2-1; do
	setarch linux64 /bin/chroot $DST/home/build/mini-native-x86_64 /var/lib/build/pkg_build $pkg
done

setarch linux64 /bin/chroot $DST/home/build/mini-native-x86_64 umount /proc
setarch linux64 /bin/chroot $DST/home/build/mini-native-x86_64 umount /sys

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
# rm -rf usr/share usr/man

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
