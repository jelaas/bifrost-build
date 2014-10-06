#!/bin/bash

V=3.17.0
SRCVER=kernel-$V
BUILDVERSION=1
PKG=musl-kernel-headers-$V-$BUILDVERSION # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Fetch sources
./Fetch-source.sh || exit $?
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
pkg_install perl-5.10.1-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
[ -d "$BUILDDIR" ] && rm -rf "$BUILDDIR"
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
function dopatch {
	echo "patch $1 < $2"
	patch $1 < $2 || exit 1
}

cd $BUILDDIR || exit 1
dopatch -p0 $PKGDIR/menuconfig.pat || exit 1

# Backported patches


#########
# Configure

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
cd $BUILDDIR || exit 1
make mrproper
make headers_check
rm -rf "$DST"
mkdir -p $DST/opt/musl
make ARCH=x86 INSTALL_HDR_PATH=$DST/opt/musl  headers_install || exit 1
echo Listing contents of $DST/opt/musl
ls -l $DST/opt/musl
echo ::: Sanitized headers installed :::

#########
# Install into dir under /var/tmp/install

mkdir -p $DST/lib/modules/$V/build/include || exit 1
mkdir -p $DST/lib/modules/$V/kernel/drivers || exit 1
mkdir -p $DST/lib/modules/$V/kernel/fs || exit 1
mkdir -p $DST/lib/modules/$V/kernel/net || exit 1
cp -a include/linux $DST/lib/modules/$V/build/include || exit 1
ln -s build $DST/lib/modules/$V/source || exit 1

mkdir -p $DST/lib/modules/$V/build/arch/x86 || exit 1
cp -a arch/x86/include $DST/lib/modules/$V/build/arch/x86 || exit 1

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
cd /var/lib/build || exit 1
rm -rf "$DST"
rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
