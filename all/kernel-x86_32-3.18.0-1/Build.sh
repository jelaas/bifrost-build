#!/bin/bash

V=3.18.0
ARCH=x86_32
SRCVER=kernel-$V
BUILDVERSION=1
PKG=kernel-$ARCH-$V-$BUILDVERSION # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DSTS="/var/tmp/install/supported-$PKG" # supported modules
DSTU="/var/tmp/install/unsupported-$PKG" # unsupported modules
DSTW="/var/tmp/install/wireless-$PKG" # wireless modules
DSTF="/var/tmp/install/firmware-$PKG" # firmware binaries
DSTV="/var/tmp/install/vmlinux-$PKG" # uncompress kernel vmlinux and System.map
DSTH="/var/tmp/install/headers-$PKG" # headers

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
pkg_install ncurses-lib-5.7-1 || exit 2
pkg_install perl-5.10.1-1 || exit 2
pkg_install passwd-file-1 || exit 2
pkg_install module-init-tools-3.15-1 || exit 2
pkg_install bifrost-initramfs-15 || exit 2
pkg_install bash-4.1-1 || exit 2
pkg_install patch-2.7.1-1 || exit 2
pkg_install bc-1.06-1 || exit 2

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
function dopatchbz {
	echo "patch $1 < $2"
	(bzcat $2|patch $1) || exit 1
}

cd $BUILDDIR || exit 1

dopatch -p0 $PKGDIR/menuconfig.pat || exit 1
dopatch -p1 $PKGDIR/ixgbe_sfp_override.pat || exit 1
dopatch -p0 $PKGDIR/ixgbe_rss.pat || exit 1
dopatch -p0 $PKGDIR/pktgen-rx.pat || exit 1

dopatch -p1 $PKGDIR/e1000.pat || exit 1
dopatch -p1 $PKGDIR/e1000e.pat || exit 1
dopatch -p1 $PKGDIR/igb.pat || exit 1
dopatch -p1 $PKGDIR/bonding.pat || exit 1

dopatch -p1 $PKGDIR/i40e_rss.pat || exit 1

dopatch -p1 $PKGDIR/niu.pat || exit 1

dopatch -p0 $PKGDIR/fiber_gecko.pat || exit 1

dopatch -p1 $PKGDIR/ipv4_per_cpu_uncached_list.pat || exit 1

#########
# Configure
cp -f $PKGDIR/config.arch bifrost-config
cat $PKGDIR/config >> bifrost-config
make KCONFIG_ALLCONFIG=bifrost-config allnoconfig
# exit 1 # This is a nice place to break if you want to change the kernel config
sed -i "s/BIFROST/${BUILDVERSION}-bifrost-$ARCH/" .config

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile

make V=1 || exit 1
echo KERNEL COMPILATION FINISHED

#########
# Install into dir under /var/tmp/install
rm -rf "$DSTS"
rm -rf "$DSTU"
rm -rf "$DSTW"
rm -rf "$DSTF"
rm -rf "$DSTV"
rm -rf "$DSTH"
mkdir -p $DSTS/boot/grub
mkdir -p $DSTV/boot
mkdir -p $DSTU
mkdir -p $DSTW
mkdir -p $DSTF
mkdir -p $DSTH

make INSTALL_MOD_PATH=$DSTS modules_install
cp arch/x86/boot/bzImage $DSTS/boot/$PKG-bifrost
ln -s $PKG-bifrost $DSTS/boot/kernel.default-$ARCH
cp System.map  $DSTV/boot/System.map-$PKG-bifrost
cp vmlinux  $DSTV/boot/vmlinux-$PKG-bifrost
echo "title   $PKG-bifrost" > $DSTS/boot/grub/$PKG-bifrost.grub
echo "root    (hd0,0)" >> $DSTS/boot/grub/$PKG-bifrost.grub
echo "kernel /boot/$PKG-bifrost rhash_entries=131072 rootdelay=10" >> $DSTS/boot/grub/$PKG-bifrost.grub

echo MODULES INSTALL FINISHED

cd $DSTS

if [ ! -d lib/modules/$V-$BUILDVERSION-bifrost-$ARCH/kernel ]; then
	echo "Modules directory 'lib/modules/$V-$BUILDVERSION-bifrost-$ARCH/kernel' missing!"
	exit 1
fi

export DSTS DSTU DSTW DSTF DSTV
find lib/modules/$V-$BUILDVERSION-bifrost-$ARCH/kernel|bash $PKGDIR/Filter.sh

echo MODULES FILTER FINISHED

# firmware to unsupported
mkdir -p $DSTF/lib
mv $DSTS/lib/firmware $DSTF/lib || exit 1

# headers
cd $BUILDDIR || exit 1
make clean
cd /var/tmp/src || exit 1
mkdir -p $DSTH/lib/modules/$V || exit 1
cp -a $SRCVER $DSTH/lib/modules/$V/build || exit 1
mkdir -p $DSTH/lib/modules/$V/kernel/drivers || exit 1
mkdir -p $DSTH/lib/modules/$V/kernel/fs || exit 1
mkdir -p $DSTH/lib/modules/$V/kernel/net || exit 1
ln -s build $DSTH/lib/modules/$V/source || exit 1
cd $DSTH/lib/modules/$V/build || exit 1
for arch in alpha arm avr32 blackfin ia64 m32r m68k microblaze mn10300 parisc powerpc s390 sh sparc tile xtensa; do
	rm -rf arch/$arch
done
rm -rf tools sound firmware Documentation drivers

#########
# Check result
cd $DSTS || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DSTS || exit 1
# rm -rf usr/share usr/man

#########
# Make package
cd $DSTS || exit 1
tar czf /var/spool/pkg/kernel-$ARCH-$V-$BUILDVERSION.tar.gz .
cd $DSTH || exit 1
tar czf /var/spool/pkg/kernel-$ARCH-headers-$V-$BUILDVERSION.tar.gz .
cd $DSTU || exit 1
tar czf /var/spool/pkg/kernel-$ARCH-unsup-$V-$BUILDVERSION.tar.gz .
cd $DSTW || exit 1
tar czf /var/spool/pkg/kernel-$ARCH-wireless-$V-$BUILDVERSION.tar.gz .
cd $DSTF || exit 1
tar czf /var/spool/pkg/kernel-$ARCH-firmware-$V-$BUILDVERSION.tar.gz .
cd $DSTV || exit 1
tar czf /var/spool/pkg/kernel-$ARCH-vmlinux-$V-$BUILDVERSION.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DSTS"
[ "$DEVEL" ] || rm -rf "$DSTU"
[ "$DEVEL" ] || rm -rf "$DSTW"
[ "$DEVEL" ] || rm -rf "$DSTF"
[ "$DEVEL" ] || rm -rf "$DSTV"
[ "$DEVEL" ] || rm -rf "$DSTH"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
